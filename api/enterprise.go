package api

import (
	"fmt"
	"net/http"

	db "github.com/darkantares/go_backend_emperatriz/db/sqlc"
	"github.com/darkantares/go_backend_emperatriz/token"
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5/pgtype"
)

type CreateEnterpriseRequest struct {
	Title                string `json:"title" binding:"required"`
	Phone                string `json:"phone" binding:"required"`
	Email                string `json:"email" binding:"required,email"`
	Contact              string `json:"contact" binding:"required"`
	ContactPhone         string `json:"contact_phone" binding:"required"`
	Files                string `json:"files" binding:"required"`
	Address              string `json:"address" binding:"required"`
	Web                  string `json:"web" binding:"required"`
	IsAuthenticated      bool   `json:"isAuthenticated"`
}

func (server *Server) createEnterprise(ctx *gin.Context) {
    var req CreateEnterpriseRequest	

    if err := ctx.ShouldBindJSON(&req); err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

    authPayload := ctx.MustGet(authorizationPayloadKey).(*token.Payload)
	user, err := server.store.GetUser(ctx, authPayload.Email)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	
	arg := db.CreateEnterpriseParams{
		Title: req.Title,
        Phone: req.Phone,
        Email: req.Email,
        Contact: req.Contact,
        ContactPhone: req.ContactPhone,
        Files: req.Files,
        Address: req.Address,
        Web: req.Web,
        IsAuthenticated: req.IsAuthenticated,
		CreatedBy: pgtype.Int4{Int32: user.ID, Valid: true},
    }

		fmt.Println(arg)
    data, err := server.store.CreateEnterprise(ctx, arg)
    if err != nil {
		if db.ErrorCode(err) == db.UniqueViolation {
			ctx.JSON(http.StatusForbidden, errorResponse(err))
			return
		}
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

    ctx.JSON(http.StatusOK, data)
}