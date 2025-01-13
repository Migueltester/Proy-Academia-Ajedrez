<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Modificar</title>

    <!-- Añade un icono a la página HTML -->
    <link rel="icon" href="img/icons/chess_40dp_FILL0_wght400_GRAD0_opsz40.svg" type="image/x-icon" />

    <!-- Importar fuente Inter de Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet" />
    <link href="styles/styles.css" rel="stylesheet" />
  </head>
  <body>
    <header class="modificarhead">
      <div class="search-container">
        <form class="search-form" method="get">
          <button type="submit"><img class="search-icon" src="img/icons/lupa.svg" alt="" /></button>
          <input type="text" name="cedula" placeholder="Buscar..." />
        </form>
      </div>
      <h1 id="mod_h1">Academia de Ajedrez</h1>
    </header>
    <main>
      <section class="seccion-modificar">
        <div class="client-info">
          <table>
            <thead>
              <tr>
                
                <th id="thead">Nombre Completo</th>
                <th id="thead">Cédula</th>
                <th id="thead">Edad</th>
                <th id="thead">Lugar de residencia</th>
                <th id="thead">Teléfono</th>
                <th id="thead">Email</th>
              </tr>
            </thead>
            <tbody>
              <%
                String cedula = request.getParameter("cedula");
                String errorMessage = "";

                if (cedula != null && !cedula.isEmpty()) {
                    Connection conexion = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        // Conexión a la base de datos
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/ajedrez", "root", "");
                        String sql = "SELECT * FROM estudiantes WHERE cedula = ?";
                        stmt = conexion.prepareStatement(sql);
                        stmt.setString(1, cedula);
                        rs = stmt.executeQuery();

                        if (rs.next()) {
              %>
                          <tr>
                            
                            <td><%= rs.getString("nombre") %></td>
                            
                            <td><%= rs.getString("cedula") %></td>
                            <td><%= rs.getString("edad") %></td>
                            <td><%= rs.getString("lugar") %></td>
                            <td><%= rs.getString("telefono") %></td>
                           <td><%= rs.getString("correo") %></td>
                          </tr>
              <%
                        } else {
                            errorMessage = "No se encontró ningún estudiante con la cédula proporcionada.";
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        errorMessage = "Error al conectar a la base de datos: " + e.getMessage();
                    } finally {
                        if (rs != null) { try { rs.close(); } catch (SQLException ignore) {} }
                        if (stmt != null) { try { stmt.close(); } catch (SQLException ignore) {} }
                        if (conexion != null) { try { conexion.close(); } catch (SQLException ignore) {} }
                    }
                } else {
                    errorMessage = "Por favor, ingrese una cédula.";
                }
              %>
            </tbody>
          </table>
          <% if (!errorMessage.isEmpty()) { %>
              <p style="color: red;"><%= errorMessage %></p>
          <% } %>
        </div>
      </section>
    </main>
    <footer>
      <div class="foot_back">
        <!--Volver button-->
        <a href="index.html">
          <div class="small-card logout ind_div">
            <img src="img/icons/arrow_back_ios_40dp_FILL0_wght600_GRAD0_opsz40.svg" alt="" />
            <h2 class="reg_cl-h2" style="margin: 20px 15px">Regresar</h2>
          </div>
        </a>
      </div>

      <div class="small-card logout ind_div">
        <img src="img/icons/picture_as_pdf_24dp_FILL0_wght400_GRAD0_opsz24.svg" alt="" />
        <h2 class="ind_h2" style="margin: 20px 15px; color: #bc3131">Exportar en PDF</h2>
      </div>

      <div class="small-card logout ind_div">
        <img src="img/icons/icons8-ms-excel.svg" alt="" />
        <h2 class="ind_h2" style="margin: 20px 15px; color: #0b6142">Exportar Excel</h2>
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
