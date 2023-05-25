
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

        <main>
            
            
            
            
            
            <%

        String url = "jdbc:mysql://localhost:3306/eservices";
            String usuario = "root";
            String contrasena = "1234";
            
            
            Connection conexion = null;
        Statement sentencia = null;
        
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        
        
    HttpSession sesion = request.getSession();
    Usuario user = (Usuario) session.getAttribute("user");
    
           String email = user.getEmail();
           String nom = user.getNombre_usuario();
           
           String accion = request.getParameter("accion");
           
           
            String nombre = request.getParameter("nom");
            String cat= request.getParameter("cat");
            String pr= request.getParameter("pr");
            String desc= request.getParameter("desc");
            
            System.out.println(nombre);
            System.out.println(cat);
            System.out.println(pr);
            System.out.println(desc);
           
            try {
            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection(url, usuario, contrasena);
            sentencia = conexion.createStatement();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
            
            
            
            
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
           

           if("Guardar".equals( accion )){
        
           try {
            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection(url, usuario, contrasena);
            sentencia = conexion.createStatement();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
           
            String consulta = "INSERT INTO Servicio (nombreS, descripcionS, precio, categoria) VALUES ('" + nombre + "', '" + desc + "', '" + pr + "', '" + cat + "')";

                try {
                sentencia.executeUpdate(consulta);
                
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            
            
            
                         String selectQuery = "SELECT id_usuario FROM Usuario WHERE email = ?";
                         statement = conexion.prepareStatement(selectQuery);
                         statement.setString(1, email);
                         resultSet = statement.executeQuery();

                         int id = 0;

                         if (resultSet.next()) {
                             id = resultSet.getInt("id_usuario");
                    }
                    
                    
                         String selectQuery1 = "SELECT id_servicio FROM Servicio WHERE nombreS = ?";
                         statement = conexion.prepareStatement(selectQuery1);
                         statement.setString(1, nombre);
                         resultSet = statement.executeQuery();

                         int ids = 0;

                         if (resultSet.next()) {
                             ids = resultSet.getInt("id_servicio");
                    }
                    
                    
                    
                    
            
                    String consulta1 = "INSERT INTO servicio_usuario (id_usuario, id_servicio) VALUES ('" + id + "', '" + ids + "')";

                        try {
                        sentencia.executeUpdate(consulta1);

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    
                    
                                   
                            %>
            <script>
            
            alert("¡exito!");
            
            </script>
            
            
<%
  

                    
                    
                    
                }
                
                
                
               
                
                
                
            
            
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
        
        

            
            
            
            
            %>
            
            
            
            
            
            
            
            
            
            

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
                                <label class="form-label">Sube La foto del servicio<span class="text-danger">*</span></label>
                                <div class="d-flex align-items-center">
                                    <label class="position-relative me-4" for="uploadfile-1" title="Replace this pic">
                                        <span class="avatar avatar-xl">
                                            <img id="uploadfile-1-preview" class="rounded" src="../../../../assets/images/avatar/01.jpg" alt="">
                                        </span>
                                    </label>
                                    <label class="btn btn-sm btn-primary-soft mb-0" for="uploadfile-1">Cambiar</label>
                                    <input id="uploadfile-1" class="form-control d-none" type="file">
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Nombre del Servicio<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="nom" id="nom" placeholder="Ingresa el nombre del Servicio">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Categoría<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="cat" id="cat" placeholder="Ingresa la categoría del servicio">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Precio<span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="pr" id="pr" placeholder="Ingresa el precio">
                            </div>
                            <div class="col-10">
                                <label class="form-label">Descripción</label>
                                <textarea class="form-control" name="desc" id="desc" rows="3" spellcheck="false"></textarea>
                            </div>
                            <div class="col-12 text-end">
                                <div><button type="submit" class="btn btn-primary mb-0" name = "accion" id="accion" value ="Guardar">Agregar</button></div>

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