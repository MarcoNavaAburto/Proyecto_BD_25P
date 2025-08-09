<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="es-Mx">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Características de la CDMX</title>
</head>

<body>

    <%!
        Connection con;
        Statement stmt;
        ResultSet rs;
        String dburl = "jdbc:postgresql://localhost:5432/proyecto_ibu";
        String user = "postgres";
        String password = "";
    %>

    <%
        Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection(dburl,user,password);
        stmt = con.createStatement();
    %>

    La Ciudad de México cuenta con 16 alcaldías, las cuales se enlistan a continuación:<br>

    <table border="1">
        <tr>
            <th>Nombre Alcaldía</th>
            <th>Abreviación</th>
        </tr>
        <tr>
            <td>Álvaro Obregón</td>
            <td>AO</td>
        </tr>
        <tr>
            <td>Azcapotzalco</td>
            <td>AZ</td>
        </tr>
        <tr>
            <td>Benito Juárez</td>
            <td>BJ</td>
        </tr>
        <tr>
            <td>Coyoacán</td>
            <td>CO</td>
        </tr>
        <tr>
            <td>Cuajimalpa de Morelos</td>
            <td>CUJ</td>
        </tr>
        <tr>
            <td>Cuauhtémoc</td>
            <td>CUAU</td>
        </tr>
        <tr>
            <td>Gustavo A. Madero</td>
            <td>GAM</td>
        </tr>
        <tr>
            <td>Iztacalco</td>
            <td>IZ</td>
        </tr>
        <tr>
            <td>Iztapalapa</td>
            <td>IZTA</td>
        </tr>
        <tr>
            <td>La Magdalena Contreras</td>
            <td>MAG</td>
        </tr>
        <tr>
            <td>Miguel Hidalgo</td>
            <td>MH</td>
        </tr>
        <tr>
            <td>Milpa Alta</td>
            <td>MA</td>
        </tr>
        <tr>
            <td>Tláhuac</td>
            <td>TLH</td>
        </tr>
        <tr>
            <td>Tlalpan</td>
            <td>TLP</td>
        </tr>
        <tr>
            <td>Venustiano Carranza</td>
            <td>VC</td>
        </tr>
        <tr>
            <td>Xochimilco</td>
            <td>XO</td>
        </tr>
    </table>

    <br>
    La CDMX cuenta con una superficie de 148180.09 ha, del cual el 41.17% es considerada un área natural mientras que un
    16.15% es un área natural protegida

    <br>
    Para ver información sobre las características de las superficies de las alcaldías de la CDMX, seleccione el botón
    todas las alcaldías para ver la información de todas las demarcaciones de la ciudad, o presione el botón consultar
    alcaldía si quiere revisar la información de una alcaldía en especifico, tenga en cuenta que tiene que agregar la
    abreviación la alcaldía de la cual desea saber la información

    <form action="caracteristicasCDMX.jsp" method="post">

        <input type="submit" value="Todas las alcaldias" name="todasAlcaldias">
        <label for="abreviacionAlcaldia">Abreviación de la alcaldía:</label>
        <input type="text" name="abreviacionAlcaldia">
        <input type="submit" value="ConsultarAlcaldia" name = "consultarAlcaldia">
    </form>

<%
    // Recuperando la información del formulario
    String todasAlcaldias = request.getParameter("todasAlcaldias");
    String abreviacionAlcaldia = request.getParameter("abreviacionAlcaldia");
    String consultarAlcaldia = request.getParameter("consultarAlcaldia");

    if (todasAlcaldias != null) {
        String query = "SELECT * FROM alcaldia";
        rs = stmt.executeQuery(query);
%>
        <h2>Listado de todas las alcaldias</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>ID Alcaldía</th>
                    <th>Nombre</th>
                    <th>Número de Habitantes</th>
                    <th>Superficie</th>
                    <th>Superficie AN</th>
                    <th>Superficie ANP</th>
                </tr>
            </thead>
            <tbody>
            <%
                while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getString("idAlcaldia") %></td>
                    <td><%= rs.getString("nombreAlcaldia") %></td>
                    <td><%= rs.getInt("numeroHabitantes") %></td>
                    <td><%= rs.getFloat("superficie") %></td>
                    <td><%= rs.getFloat("superficieAN") %></td>
                    <td><%= rs.getFloat("superficieANP") %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
<%
    } else if (consultarAlcaldia != null) {
        if (abreviacionAlcaldia != null && !abreviacionAlcaldia.trim().isEmpty()) {
            out.println("<p>Mostrando información de la alcaldía: " + abreviacionAlcaldia + "</p>");
            String queryAlcaldia = "SELECT * FROM alcaldia WHERE idAlcaldia = ?";
            PreparedStatement pstmt = con.prepareStatement(queryAlcaldia);
            pstmt.setString(1, abreviacionAlcaldia.trim());
            ResultSet rsAlcaldia = pstmt.executeQuery();
            if (rsAlcaldia.next()) {
%>
                <table border="1">
                    <thead>
                        <tr>
                            <th>ID Alcaldía</th>
                            <th>Nombre</th>
                            <th>Número de Habitantes</th>
                            <th>Superficie</th>
                            <th>Superficie AN</th>
                            <th>Superficie ANP</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%= rsAlcaldia.getString("idAlcaldia") %></td>
                            <td><%= rsAlcaldia.getString("nombreAlcaldia") %></td>
                            <td><%= rsAlcaldia.getInt("numeroHabitantes") %></td>
                            <td><%= rsAlcaldia.getFloat("superficie") %></td>
                            <td><%= rsAlcaldia.getFloat("superficieAN") %></td>
                            <td><%= rsAlcaldia.getFloat("superficieANP") %></td>
                        </tr>
                    </tbody>
                </table>
<%
            } 
            else 
            {
                out.println("<p style='color:red;'>No se encontró información para la abreviación proporcionada.</p>");
            }
            rsAlcaldia.close();
            pstmt.close();
        } 
        else 
        {
            out.println("<p style='color:red;'>Por favor ingrese una abreviación</p>");
        }
    } 
    else 
    {
        out.println("<p style='color:red;'>Seleccione una opción válida.</p>");
    }
%>
    <%
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (con != null) con.close();
    %>

</body>

</html>