<%@page import="org.eServices.dao.Usuario"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services - Cuenta de Trabajador</title>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="author" content="Webestica.com">
        <meta name="description" content="e-Services">

        <script>
            const storedTheme = localStorage.getItem('theme');

            const getPreferredTheme = () => {
                if (storedTheme) {
                    return storedTheme;
                }
                return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
            };

            const setTheme = function (theme) {
                if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
                    document.documentElement.setAttribute('data-bs-theme', 'dark');
                } else {
                    document.documentElement.setAttribute('data-bs-theme', theme);
                }
            };

            setTheme(getPreferredTheme());

            window.addEventListener('DOMContentLoaded', () => {
                var el = document.querySelector('.theme-icon-active');
                if (el !== 'undefined' && el !== null) {
                    const showActiveTheme = theme => {
                        const activeThemeIcon = document.querySelector('.theme-icon-active use');
                        const btnToActive = document.querySelector(`[data-bs-theme-value="${theme}"]`);
                        const svgOfActiveBtn = btnToActive.querySelector('.mode-switch use').getAttribute('href');

                        document.querySelectorAll('[data-bs-theme-value]').forEach(element => {
                            element.classList.remove('active');
                        });

                        btnToActive.classList.add('active');
                        activeThemeIcon.setAttribute('href', svgOfActiveBtn);
                    };

                    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
                        if (storedTheme !== 'light' || storedTheme !== 'dark') {
                            setTheme(getPreferredTheme());
                        }
                    });

                    showActiveTheme(getPreferredTheme());

                    document.querySelectorAll('[data-bs-theme-value]')
                            .forEach(toggle => {
                                toggle.addEventListener('click', () => {
                                    const theme = toggle.getAttribute('data-bs-theme-value');
                                    localStorage.setItem('theme', theme);
                                    setTheme(theme);
                                    showActiveTheme(theme);
                                });
                            });

                }
            });

        </script>

        <link rel="shortcut icon" href="../../../../assets/images/favicon.ico">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&family=Poppins:wght@400;500;700&display=swap">

        <link rel="stylesheet" type="text/css" href="../../../../assets/vendor/font-awesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="../../../../assets/vendor/bootstrap-icons/bootstrap-icons.css">
        <link rel="stylesheet" type="text/css" href="../../../../assets/vendor/overlay-scrollbar/css/overlayscrollbars.min.css">
        <link rel="stylesheet" type="text/css" href="../../../../assets/vendor/choices/css/choices.min.css">

        <link rel="stylesheet" type="text/css" href="../../../../assets/css/style.css">

    </head>

    <body>
        
        
        <%
    
            String url = "jdbc:mysql://localhost:3306/eservices";
            String usuario = "root";
            String contrasena = "1234";
            
            
            Connection conexion = null;
            Statement sentencia = null;
        
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection(url, usuario, contrasena);
            sentencia = conexion.createStatement();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        
        
    HttpSession sesion = request.getSession();
    Usuario user = (Usuario) session.getAttribute("user");
    
           String email = user.getEmail();
           String nom = user.getNombre_usuario();
           String apm = user.getApellido_m();
           String app = user.getApellido_p();
           String curp = user.getCurp();
           
           String tel = "";
           String col ="";
           String calle ="";
           String numI = "";
           String numE ="";
           String codP = "";
           
           
                                   if (nom == null){
           
            String Query0 = "SELECT nombre FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(Query0);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             nom = "";
            
            
            if (resultSet.next()) {
                nom = resultSet.getString("nombre");
            }
             }
           
           
           String selectQuery5 = "SELECT colonia FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery5);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             col = "";
            
            
            if (resultSet.next()) {
                col = resultSet.getString("colonia");
            }
            
            
            
            String selectQuery6 = "SELECT calle FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery6);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             calle = "";
            
            
            if (resultSet.next()) {
                calle = resultSet.getString("calle");
            }
            
            
            
            
            
            String selectQuery7 = "SELECT num_ext FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery7);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             numE = "";
            
            
            if (resultSet.next()) {
                numE = resultSet.getString("num_ext");
            }
            
            
            
            String selectQuery8 = "SELECT num_int FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery8);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             numI = "";
            
            
            if (resultSet.next()) {
                numI = resultSet.getString("num_int");
            }
            
            
            
            
            String selectQuery9 = "SELECT codigo_postal FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery9);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             codP = "";
            
            
            if (resultSet.next()) {
                codP = resultSet.getString("codigo_postal");
            }

            
            String selectQuery10 = "SELECT celular FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery10);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             tel = "";
            
            
            if (resultSet.next()) {
                tel = resultSet.getString("celular");
            }
           
           
           
           


           if (apm == null){
           
            String selectQuery = "SELECT nombre FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             nom = "";
            
            
            if (resultSet.next()) {
                nom = resultSet.getString("nombre");
            }
            
            
            
            
            String selectQuery1 = "SELECT apellido_p FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery1);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             app = "";
            
            
            if (resultSet.next()) {
                app = resultSet.getString("apellido_p");
            }
            
            
            
            String selectQuery2 = "SELECT apellido_m FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery2);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             apm = "";
            
            
            if (resultSet.next()) {
                apm = resultSet.getString("apellido_m");
            }
            
            
            String selectQuery3 = "SELECT curp FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery3);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             curp = "";
            
            
            if (resultSet.next()) {
                curp = resultSet.getString("curp");
            }

            }
            
            String accion = request.getParameter("accion");

            if ("Guardar".equals( accion )){
            

            apm = request.getParameter("apellido_m");
            app = request.getParameter("apellido_p");
            nom = request.getParameter("nom");
            tel= request.getParameter("tel");
            col = request.getParameter("col");
            calle = request.getParameter("calle");
            numI = request.getParameter("numI");
            numE = request.getParameter("numE");
            codP = request.getParameter("cod");
            
            PreparedStatement preparedStatement = null;
            
            String consulta = "UPDATE Usuario SET apellido_p = ?, apellido_m = ?, nombre = ?, celular = ?, colonia = ?, calle = ?, num_ext = ?, num_int = ?, codigo_postal = ? WHERE email = ?";
            preparedStatement = conexion.prepareStatement(consulta);
            preparedStatement.setString(1, app );
            preparedStatement.setString(2, apm );
            preparedStatement.setString(3, nom);
            preparedStatement.setString(4, tel);
            preparedStatement.setString(5, col);
            preparedStatement.setString(6, calle);
            preparedStatement.setString(7, numE);
            preparedStatement.setString(8, numI);
            preparedStatement.setString(9, codP);
            preparedStatement.setString(10, email);
            preparedStatement.executeUpdate();
            
            
            
            try {
            if (sentencia != null) {
                sentencia.close();
            }
            if (conexion != null) {
                conexion.close();
            }
            } catch (SQLException e) {
                 e.printStackTrace();
            }
            
            
            
                }
            



 
    %>
        

        <main>

            <nav class="navbar sidebar navbar-expand-xl navbar-light">
                <div class="d-flex align-items-center">
                    <a class="navbar-brand" >
                        <img class="light-mode-item navbar-brand-item" src="../../../../assets/images/logo.svg" alt="logo">
                        <img class="dark-mode-item navbar-brand-item" src="../../../../assets/images/logo-light.svg" alt="logo">
                    </a>
                </div>

                <div class="offcanvas offcanvas-start flex-row custom-scrollbar h-100" data-bs-backdrop="true" tabindex="-1" id="offcanvasSidebar">
                    <div class="offcanvas-body sidebar-content d-flex flex-column pt-4">

                        <ul class="navbar-nav flex-column" id="navbar-sidebar">



                            <li class="nav-item"><a class="nav-link" href="admin-agent-edit.jsp">Trabajador</a></li>
                            <li class="nav-item"> <a class="nav-link" href="admin-earnings.jsp">Agregar Tarjeta</a></li>
                            <li class="nav-item"> <a class="nav-link" href="admin-agregars.jsp">Agregar Servicio</a></li>
                            <li class="nav-item"> <a class="nav-link" href="admin-miservicios.jsp">Mis Servicios</a></li>


                        </ul>

                        <div class="d-flex align-items-center justify-content-between text-primary-hover mt-auto p-3">
                            <a class="h6 fw-light mb-0 text-body" href="../../../../index.html">
                                <i class="fa-solid fa-arrow-right-from-bracket"></i> Log out 
                            </a>

                        </div>

                    </div>
                </div>
            </nav>
            <div class="page-content">

                <nav class="navbar top-bar navbar-light py-0 py-xl-3">
                    <div class="container-fluid p-0">
                        <div class="d-flex align-items-center w-100">

                            <div class="d-flex align-items-center d-xl-none">
                                <a class="navbar-brand" >
                                    <img class="navbar-brand-item h-40px" src="../../../../assets/images/logo-icon.svg" alt="">
                                </a>
                            </div>

                            <div class="navbar-expand-xl sidebar-offcanvas-menu">
                                <button class="navbar-toggler me-auto p-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasSidebar" aria-controls="offcanvasSidebar" aria-expanded="false" aria-label="Toggle navigation" data-bs-auto-close="outside">
                                    <i class="bi bi-list text-primary fa-fw" data-bs-target="#offcanvasMenu"></i>
                                </button>
                            </div>

                        </div>
                    </div>
                </nav>
                <div class="page-content-wrapper p-xxl-4">
                    <div class="card-body">
                                        <form class="row g-3">
                                            <div class="col-12">
                                                <label class="form-label">Sube Tu Foto De Perfil<span class="text-danger">*</span></label>
                                                <div class="d-flex align-items-center">
                                                    <label class="position-relative me-4" for="uploadfile-1" title="Replace this pic">
                                                        <span class="avatar avatar-xl">
                                                            <img id="uploadfile-1-preview" class="avatar-img rounded-circle border border-white border-3 shadow" src="../../../../assets/images/avatar/01.jpg" alt="">
                                                        </span>
                                                    </label>
                                                    <label class="btn btn-sm btn-primary-soft mb-0" for="uploadfile-1">Cambiar</label>
                                                    <input id="uploadfile-1" class="form-control d-none" type="file">
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label">Nombre(s)<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control"  name="nom" id="nom" placeholder="Introduce tu nombre">
                                            </div>
                       
                                            <div class="col-md-6">
                                                <label class="form-label">Apellido Paterno<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" name="apellido_p" id="apellido_p" placeholder="Introduce tu apellido">
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label">Número De Celular<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control"  name="tel" id="tel" placeholder="Introduce tu celular">
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Apellido Materno<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control"  name="apellido_m" id="apellido_m" placeholder="Introduce tu apellido">
                                            </div>


                            
                                            

                                            <div class="col-md-6">
                                                <label class="form-label">Colonia<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" name="col" id="col"  placeholder=<%= col%>>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label">Código Postal<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" name="cod" id="cod"  placeholder=<%= codP%>>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label">Calle<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" name="calle" id="calle"  placeholder=<%= calle%>>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Número exterior<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" name="numE" id="numE"  placeholder=<%= numE%>>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label">Número Interior<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" name="numI" id="numI"  placeholder=<%= numI%>>
                                            </div>

                                            <div class="col-12 text-end">
                                                <button type="submit" class="btn btn-primary mb-0" name = "accion" id="accion" value ="Guardar">Guardar Cambios</button>

                                            </div>
                                        </form>
                                    </div>



                </div> 
            </div>


        </main>

        <script src="../../../../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

        <script src="../../../../assets/vendor/overlay-scrollbar/js/overlayscrollbars.min.js"></script>
        <script src="../../../../assets/vendor/choices/js/choices.min.js"></script>

        <script src="../../../../assets/js/functions.js"></script>

    </body>
</html>