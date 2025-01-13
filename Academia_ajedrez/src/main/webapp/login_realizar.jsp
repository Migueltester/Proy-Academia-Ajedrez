<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>
    <link rel="icon" href="img/icons/chess_40dp_FILL0_wght400_GRAD0_opsz40.svg" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet" />
    <link rel="preload" href="styles/styles.css" as="style" />
    <link href="styles/styles.css" rel="stylesheet" />
</head>
<body>
    <header>
        <div class="contenedor_logo">
            <img src="img/icons/ACADEMIA.svg" class="logo" />
        </div>
        <h1 id="log_h1">BIENVENIDO</h1>
    </header>
    <main>
        <section class="sect_login">
            <div class="log_container1">
                <form id="log_form" method="post" action="login_realizar.jsp">
                    <img id="log_img" src="img/icons/chess_48dp_FILL0_wght400_GRAD0_opsz48.svg" alt="" />
                    <h2 id="log_h2">Inicia sesión</h2>
                    <h3 id="log_h3">para continuar a la Academia de Ajedrez</h3>

                    <div class="input-box">
                        <input type="text" name="user" placeholder="Usuario" required />
                    </div>

                    <div class="input-box">
                        <input type="password" name="password" placeholder="Contraseña" required />
                    </div>
                     <% 
                    String user = request.getParameter("user");
                    String password = request.getParameter("password");
                    String errorMessage = "";

                    if (user != null && password != null) {
                        try {
                            // Conexion a la base de datos
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ajedrez", "root", "");
                            PreparedStatement stmt = dbConnection.prepareStatement("SELECT * FROM usuarios1 WHERE usuario=? AND contrasena=?");
                            stmt.setString(1, user);
                            stmt.setString(2, password);
                            ResultSet rs = stmt.executeQuery();

                            if (rs.next()) {
                                // Redirigir a la página de inicio si el login es correcto
                                response.sendRedirect("index.html");
                            } else {
                                // Mostrar mensaje de error si el login es incorrecto
                                errorMessage = "Usuario o contraseña incorrecto";
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            errorMessage = "Error al conectar a la base de datos";
                        }
                    }
                %>
                <% if (!errorMessage.isEmpty()) { %>
                    <a class="blink log_z1 rec-pass1" href="#"><%= errorMessage %></a>
                <% } %>

                    <div class="texto-registro">
                    
                        <a class="log_a" href="#">¿Olvidaste tu contraseña?</a>
                        <button type="submit" class="boton">Siguiente</button>
                    </div>
                </form>
               
            </div>
        </section>
    </main>
    <footer id="log_foot">
        <a class="log_a" href="" target="_blank">¿Necesitas ayuda?</a>
    </footer>
</body>
</html>
