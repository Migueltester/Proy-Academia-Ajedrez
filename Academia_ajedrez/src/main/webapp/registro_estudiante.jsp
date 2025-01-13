<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registrar Cliente</title>

    <!-- Añade un icono a la página HTML -->
    <link rel="icon" href="img/icons/chess_40dp_FILL0_wght400_GRAD0_opsz40.svg" type="image/x-icon" />

    <!-- Importar fuente Inter de Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet" />

    <link rel="preload" href="styles/styles.css" as="style" />
    <link rel="stylesheet" href="styles/styles.css" />
  </head>
  <body>
    <header id="reg_cl-header">
      <div class="contenedor_logo">
        <img src="img/icons/ACADEMIA.svg" class="logo" />
      </div>
      <h1 id="log_h1">Academia de Ajedrez</h1>
    </header>

    <main>
      <div class="reg_text">
        <h2 class="ind_h2 reg_cl-h2">Registro del cliente</h2>
      </div>

      <section class="reg-cl_container real_display">
        <%-- Obtener los parámetros del formulario --%>
        <%
            String nombre = request.getParameter("nombre");
            String cedula = request.getParameter("cedula");
            String edad = request.getParameter("edad");
            String lugar = request.getParameter("lugar");
            String telefono = request.getParameter("telefono");
            String correo = request.getParameter("correo");
            String nivel = request.getParameter("nivel");

            boolean hasError = (nombre == null || nombre.isEmpty() ||
                                cedula == null || cedula.isEmpty() ||
                                edad == null || edad.isEmpty() ||
                                lugar == null || lugar.isEmpty() ||
                                telefono == null || telefono.isEmpty() ||
                                correo == null || correo.isEmpty() ||
                                nivel == null || nivel.isEmpty());
                                
            String errorMessage = "";
        %>

        <% if (hasError) { 
        	errorMessage = "Error en el registro. Algunos campos están vacíos. Por favor, intente nuevamente.";
         } else { %>
            <%-- Inicializar variables de conexión --%>
            <% Connection conexion = null;
               PreparedStatement orden = null;
               try {
                   // Cargar el driver de MySQL
                   Class.forName("com.mysql.cj.jdbc.Driver");

                   // Establecer la conexión con la base de datos MySQL
                   conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/ajedrez", "root", "");

                   // SQL para insertar los datos
                   String orden_sql = "INSERT INTO estudiantes (nombre, cedula, edad, lugar, telefono, correo, nivel) VALUES (?, ?, ?, ?, ?, ?, ?)";

                   // Preparar la declaración
                   orden = conexion.prepareStatement(orden_sql);

                   // Establecer los valores
                   orden.setString(1, nombre);
                   orden.setString(2, cedula);
                   orden.setString(3, edad);
                   orden.setString(4, lugar);
                   orden.setString(5, telefono);
                   orden.setString(6, correo);
                   orden.setString(7, nivel);

                   // Ejecutar la inserción
                   int filasInsertadas = orden.executeUpdate();

                   // Mostrar mensaje de éxito o error
                   if (filasInsertadas > 0) { %>
                       <h2>Registro exitoso</h2>
                       <div class="text-field">
                       <img  src="img/realizado.gif" width="90px" height="90px" style="margin-bottom: 30px;">
                           <p>Nombre: <%= nombre %></p>
                           <p>Cédula: <%= cedula %></p>
                           <p>Edad: <%= edad %></p>
                           <p>Lugar de residencia: <%= lugar %></p>
                           <p>Teléfono: <%= telefono %></p>
                           <p>Correo electrónico: <%= correo %></p>
                           <p>Nivel: <%= nivel %></p>
                       </div>
                   <% } else { 
                       errorMessage = "Error en el registro. Intente nuevamente.";
                    }
               } catch (Exception e) {
                   e.printStackTrace();
                   errorMessage = "Error al conectar a la base de datos";
               } finally {
                   // Cerrar la conexión
                   if (orden != null) { try { orden.close(); } catch (SQLException ignore) {} }
                   if (conexion != null) { try { conexion.close(); } catch (SQLException ignore) {} }
               }
            %>
        <% } %>
        
        <% if (!errorMessage.isEmpty()) { %>
            <a class="blink log_z1 rec-pass1"  style=" margin-top: 30px;" href="registrar-cliente.html"><%= errorMessage %></a>
            <img  src="img/Error.gif" width="220px" height="220px">
            
        <% } %>
      </section>

      <footer>
        <div class="foot_back">
          <!--Volver button-->
          <a href="registrar.html">
            <div class="small-card logout ind_div">
              <img src="img/icons/arrow_back_ios_40dp_FILL0_wght600_GRAD0_opsz40.svg" alt="" />
              <h2 class="reg_cl-h2" style="margin: 20px 15px">Regresar</h2>
            </div>
          </a>

          <!--LOGOUT button-->
          <a href="index.html">
            <div class="small-card logout ind_div">
              <img src="img/icons/home_40dp_FILL0_wght400_GRAD0_opsz40.svg" alt="" />
              <h2 class="reg_cl-h2" style="margin: 20px 15px">Volver al home</h2>
            </div>
          </a>
        </div>

        <!-- INFORMACION LOGIN  -->
        <ul class="ind_ul">
          <li class="ind_li">Sesión iniciada como:</li>
          <li class="ind_li">
            <img src="img/icons/shield_person_48dp_FILL0_wght400_GRAD0_opsz48.svg" alt="Admin Icon" />
            Administrador
          </li>
        </ul>
      </footer>
  </body>
</html>
