SRC_PATH = 		srcs/
SRC =			$(addprefix $(SRC_PATH),$(SRC_NAME))
SRC_NAME +=		burningship.c 
SRC_NAME +=		burningship_next.c 
SRC_NAME +=		color.c 
SRC_NAME +=		conversion.c 
SRC_NAME +=		fill_pixel.c
SRC_NAME +=		julia.c
SRC_NAME +=		julia_next.c
SRC_NAME +=		key_input.c 
SRC_NAME +=		main.c 
SRC_NAME +=		manage_func.c 
SRC_NAME +=		mandelbrot.c 
SRC_NAME +=		mandelbrot_next.c 
SRC_NAME +=		mouse_input.c 
SRC_NAME +=		zoom.c 

OBJ_PATH =		objs/
OBJ_NAME = 		$(SRC_NAME:.c=.o)
OBJ =			$(addprefix $(OBJ_PATH),$(OBJ_NAME))

INC = 			-I include -I libft -I minilibx_macos

LDLIBS = 		-lft
LDFLAGS = 		-L libft
LIBFT_PATH = 	libft/
LIBFT = 		$(LIBFT_PATH)libft.a

MLXFLAGS = 		-L minilibx_macos
MLXLIBS = 		-lmlx -framework OpenGL -framework AppKit
MLX_PATH = 		minilibx_macos/
MLX = 			$(MLX_PATH)libmlx.a

CC = 			clang
CFLAGS = 		-g -Wall -Wextra -Werror
NAME = 			fractol

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(MLX) $(LIBFT) $(OBJ)
	$(CC) $(INC) $(LDFLAGS) $(LDLIBS) $(MLXFLAGS) $(MLXLIBS) $^ -o $@

$(OBJ_PATH)%.o: $(SRC_PATH)%.c include/*
	mkdir -p objs
	$(CC) $(CFLAGS) $(INC)  -o $@ -c $<

$(MLX):
	make -C $(MLX_PATH)

$(LIBFT):
	@make -C $(LIBFT_PATH)

clean:
	rm -rfv $(OBJ_PATH)
	@make -C $(MLX_PATH) clean
	@make -C $(LIBFT_PATH) clean

fclean: clean
	rm -fv $(NAME)
	@make -C $(LIBFT_PATH) fclean

re: fclean all
