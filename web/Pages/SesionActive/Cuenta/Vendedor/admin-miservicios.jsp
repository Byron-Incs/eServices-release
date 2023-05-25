<%@page import="org.eServices.dao.Usuario"%>
<%@page import="org.eServices.dao.Servicio"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services - Ingresos de Trabajador</title>

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

        
        
    HttpSession sesion = request.getSession();
    Usuario user = (Usuario) session.getAttribute("user");
    
           String email = user.getEmail();
           String nom = user.getNombre_usuario();


           
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


                    String selectQuery = "SELECT id_usuario FROM Usuario WHERE email = ?";
                     statement = conexion.prepareStatement(selectQuery);
                    statement.setString(1, email);
                     resultSet = statement.executeQuery();

                    int id = 0;

                    if (resultSet.next()) {
                        id = resultSet.getInt("id_usuario");
                    }

                    String query = "SELECT id_servicio FROM servicio_usuario WHERE id_usuario = ?";
                    statement = conexion.prepareStatement(query);
                    statement.setInt(1, id);
                    resultSet = statement.executeQuery();

                    ArrayList<Integer> idS = new ArrayList<>();

                    while (resultSet.next()) {
                        int x = resultSet.getInt("id_servicio");
                        idS.add(x);
                    }

                    ArrayList<Servicio> services = new ArrayList<>();

                    for (int i = 0; i < idS.size(); i++) {
                        String selectQuery2 = "SELECT * FROM Servicio WHERE id_servicio = ?";
                        statement = conexion.prepareStatement(selectQuery2);
                        statement.setInt(1, idS.get(i));
                        resultSet = statement.executeQuery();

                        if (resultSet.next()) {
                            Servicio service = new Servicio();
                            service.setCategoria(resultSet.getString("categoria"));
                            service.setDescripcionS(resultSet.getString("descripcionS"));
                            service.setNombreS(resultSet.getString("nombreS"));
                            service.setPrecio(resultSet.getString("precio"));
                            services.add(service);
                        }
                    }


                


                
                
                try {
            if (sentencia != null) {
                sentencia.close();
            }
            if (conexion != null) {
                conexion.close();
            }
            } catch (SQLException e) {}
         
            
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

                <div class="card-body p-0">

                    <ul class="nav nav-tabs nav-bottom-line nav-responsive nav-justified">
                        <li class="nav-item">
                            <a class="nav-link mb-0 active" data-bs-toggle="tab" href="#tab-1"><i class="bi bi-briefcase-fill fa-fw me-1"></i>Mis Servicios</a>
                        </li>
                    </ul>

                    <div class="tab-content p-2 p-sm-4" id="nav-tabContent">

                        
                            <%
    
                                        for (int i = 0; i < services.size(); i++) {
                                               String nombre = services.get(i).getNombreS();
                                               String categoria = services.get(i).getCategoria();
                                               String precio = services.get(i).getPrecio();


%>
                                                        
                                                        
                                                        <div class="card border">
                                                            <div class="card-header border-bottom d-md-flex justify-content-md-between align-items-center">
                                                                <div class="d-flex align-items-center">
                                                                    <div class="icon-lg bg-light rounded-circle flex-shrink-0"><i class="bi bi-flower1"></i></div>
                                                                    <div class="ms-2">
                                                                        <h6 class="card-title mb-0"><%=nombre%></h6>
                                                                  
                                                                    </div>
                                                                </div>

                  
                                                            </div>

                                                            <div class="card-body">
                                                                <div class="row g-3">
                                                                    <div class="col-sm-6 col-md-4">
                                                                        <span>Categoria</span>
                                                                        <h6 class="mb-0"><%= categoria%></h6>
                                                                    </div>

                                                                    <div class="col-sm-6 col-md-4">
                                                                        <span>Precio</span>
                                                                        <h6 class="mb-0">$ <%= precio%></h6>
                                                                    </div>

                                                              
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        
                                                       <%
                                                           }
                                                       %> 
                        </div>
                        <div class="tab-pane fade" id="tab-2">
                            <h6>Cancelar Servicio</h6>

                            <div class="card border">
                                <div class="card-header border-bottom d-md-flex justify-content-md-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <div class="icon-lg bg-light rounded-circle flex-shrink-0"><i class="bi bi-gear-fill"></i></div>
                                        <div class="ms-2">
                                            <h6 class="card-title mb-0">Servicio de Plomeria</h6>
                                            <ul class="nav nav-divider small">
                                                <li class="nav-item">Service ID: CGDSUAHA12548</li>
                                                <li class="nav-item">Mantenimiento</li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="mt-2 mt-md-0">
                                        <p class="text-danger text-md-end mb-0">Servicio Cancelado</p>
                                    </div>
                                </div>

                                <div class="card-body">
                                    <div class="row g-3">
                                        <div class="col-sm-6 col-md-4">
                                            <span>Dirección</span>
                                            <h6 class="mb-0">Aquella casa</h6>
                                        </div>

                                        <div class="col-sm-6 col-md-4">
                                            <span>Horario Acordado</span>
                                            <h6 class="mb-0">Tue 12 Aug</h6>
                                        </div>

                                        <div class="col-md-4">
                                            <span>Iba a ser realizado por</span>
                                            <h6 class="mb-0">Frances Guerrero</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="tab-3">
                            <div class="bg-mode shadow p-4 rounded overflow-hidden">
                                <div class="row g-4 align-items-center">
                                    <div class="col-md-9">
                                        <h6>Aún no has completado ningún servicio</h6>
                                        <h4 class="mb-2">Cuando completes un servicio sera mostrado aqui.</h4>
                                        <a href="hotel-list.html" class="btn btn-primary-soft mb-0">Comienza a contratar</a>
                                    </div>
                                    <div class="col-md-3 text-end">
                                        <img src="../../../../assets/images/element/17.svg" class="mb-n5" alt="">
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>

        </main>

        <script src="../../../../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

        <script src="../../../../assets/vendor/overlay-scrollbar/js/overlayscrollbars.min.js"></script>

        <script src="../../../../assets/js/functions.js"></script>

    </body>
</html>