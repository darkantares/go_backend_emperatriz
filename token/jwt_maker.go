package token

import (
	"errors"
	"fmt"
	"log"
	"time"

	"github.com/darkantares/go_backend_emperatriz/util"
	"github.com/golang-jwt/jwt/v5"
)

type JWTPayloadClaims struct {
    Payload
    jwt.RegisteredClaims
}

type JWTMaker struct {
	secretKey string
}

// const minSecretKeySize = 32

func NewJWTMaker(secretKey string) (Maker, error) {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config")
	}
	if len(secretKey) < config.TokenMinSecretKeySize {
		return nil, fmt.Errorf("invalid key size: must be at least %d characters", config.TokenMinSecretKeySize)
	}
	return &JWTMaker{secretKey}, nil
}

func NewJWTPayloadClaims(payload *Payload) *JWTPayloadClaims {
    return &JWTPayloadClaims{
        Payload: *payload,
        RegisteredClaims: jwt.RegisteredClaims{
            ExpiresAt: jwt.NewNumericDate(payload.ExpiredAt),
            IssuedAt:  jwt.NewNumericDate(payload.IssuedAt),
            NotBefore: jwt.NewNumericDate(payload.IssuedAt),
            Issuer:    "simplebank",
            Subject:   payload.Email,
            ID:        payload.ID.String(),
            Audience:  []string{"clients"},
        },
    }
}

func (m *JWTMaker) CreateToken(email string, role string,duration time.Duration) (string, *Payload, error) {
    payload, err := NewPayload(email, role, duration)
    if err != nil {
        return "", payload, err
    }
 
    jwtToken := jwt.NewWithClaims(jwt.SigningMethodHS256, NewJWTPayloadClaims(payload))
    signedString, err := jwtToken.SignedString([]byte(m.secretKey))
    return signedString, payload, err
}

func (m *JWTMaker) VerifyToken(token string) (*Payload, error) {
    jwtClaims := &JWTPayloadClaims{}
    jwtToken, err := jwt.ParseWithClaims(token, jwtClaims, func(t *jwt.Token) (interface{}, error) {
        if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
            return nil, ErrInvalidToken
        }
        return []byte(m.secretKey), nil
    })
 
    if err != nil {
        if errors.Is(err, jwt.ErrTokenExpired) {
            return nil, ErrExpiredToken
        } else if errors.Is(err, ErrInvalidToken) {
            return nil, ErrInvalidToken
        } else {
            return nil, err
        }
    }
 
    payloadClaims, ok := jwtToken.Claims.(*JWTPayloadClaims)
    if !ok {
        return nil, ErrInvalidToken
    }
 
    return &payloadClaims.Payload, nil
}