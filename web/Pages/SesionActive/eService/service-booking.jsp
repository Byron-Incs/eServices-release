<%@page import="org.eServices.dao.Usuario"%>
<%@page import="org.eServices.dao.Servicio"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services - Confirmación</title>

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

        <link rel="shortcut icon" href="../../../assets/images/favicon.ico">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&family=Poppins:wght@400;500;700&display=swap">

        <link rel="stylesheet" type="text/css" href="../../../assets/vendor/font-awesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="../../../assets/vendor/bootstrap-icons/bootstrap-icons.css">
        <link rel="stylesheet" type="text/css" href="../../../assets/vendor/choices/css/choices.min.css">
        <link rel="stylesheet" type="text/css" href="../../../assets/vendor/flatpickr/css/flatpickr.min.css">
        <link rel="stylesheet" type="text/css" href="../../../assets/vendor/stepper/css/bs-stepper.min.css">

        <link rel="stylesheet" type="text/css" href="../../../assets/css/style.css">

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
           
        Servicio service = (Servicio) session.getAttribute("servicio");
        
        
        
        String nombre = service.getNombreS();
        String cat = service.getCategoria();
        String desc = service .getDescripcionS();
        String precio = service.getPrecio();
        
        int pr = Integer.parseInt(precio) + 30;
        String prS = Integer.toString(pr);

           
           String p = request.getParameter("pago");
           
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

           if (("pagar").equals(p)){
           
           
                
                
                String selectQuery = "SELECT id_usuario FROM Usuario WHERE email = ?";
                statement = conexion.prepareStatement(selectQuery);
                statement.setString(1, email);
                resultSet = statement.executeQuery();

                int id = 0;

                if (resultSet.next()) {
                     id = resultSet.getInt("id_usuario");
                  }
                  
                  String selectQuery2 = "SELECT id_servicio FROM Servicio WHERE descripcionS = ?";
                statement = conexion.prepareStatement(selectQuery2);
                statement.setString(1, desc);
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
                  
                  
                  
                  
                try {
            if (sentencia != null) {
                sentencia.close();
            }
            if (conexion != null) {
                conexion.close();
            }
            } catch (SQLException e) {}
            
            
             %>
                    
                    <script>
                            window.location.href = 'compra-realizada.html';
                    </script>
                    
                    
                    <%
            
                 
           
           
            }
           




        %>

        <header class="navbar-light header-sticky">
            <nav class="navbar navbar-expand-xl">
                <div class="container">
                    <a class="navbar-brand" href="../home-page.jsp">
                        <img class="light-mode-item navbar-brand-item" src="../../../assets/images/logo.svg" alt="logo">
                        <img class="dark-mode-item navbar-brand-item" src="../../../assets/images/logo-light.svg" alt="logo">
                    </a>
                    

                    <button class="navbar-toggler ms-sm-auto mx-3 me-md-0 p-0 p-sm-2" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCategoryCollapse" aria-controls="navbarCategoryCollapse" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="bi bi-grid-3x3-gap-fill fa-fw"></i><span class="d-none d-sm-inline-block small">Category</span>
                    </button>

                   
                    


                            

                            
                            <div class="navbar-collapse collapse" id="navbarCategoryCollapse">
                                <ul class="navbar-nav navbar-nav-scroll nav-pills-primary-soft text-center ms-auto p-2 p-xl-0">
                                    <li class="nav-item"> <a class="nav-link" href="../eService/service-grid.jsp"><i class="bi bi-bucket-fill"></i>Servicios</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="../../Generics/coming-soon.html"><i class="fa-solid fa-car fs-5"></i>Transporte</a></li>
                                </ul>
                            </div>
                            <ul class="nav flex-row align-items-center list-unstyled ms-xl-auto">
                                <li class="nav-item ms-3 dropdown">
                                    <a class="avatar avatar-sm p-0" href="#" id="profileDropdown" role="button" data-bs-auto-close="outside" data-bs-display="static" data-bs-toggle="dropdown" aria-expanded="false">
                                        <img class="avatar-img rounded-2" src="../../../assets/images/avatar/01.jpg" alt="avatar">
                                    </a>

                                    <ul class="dropdown-menu dropdown-animation dropdown-menu-end shadow pt-3" aria-labelledby="profileDropdown">
                                        <li class="px-3 mb-3">
                                            <div class="d-flex align-items-center">
                                                <div class="avatar me-3">
                                                    <img class="avatar-img rounded-circle shadow" src="../../../assets/images/avatar/01.jpg" alt="avatar">
                                                </div>
                                                <div>
                                                    <a class="h6 mt-2 mt-sm-0" href="#"><%=nom%></a>
                                                    <p class="small m-0"><%=email%></p>
                                                </div>
                                            </div>
                                        </li>

                                        <li> <hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="../Cuenta/Cliente/account-bookings.jsp"><i class="bi bi-ticket-perforated fa-fw me-2"></i>Mis Servicios</a></li>
                                        <li><a class="dropdown-item bg-danger-soft-hover" href="../../../index.html"><i class="bi bi-power fa-fw me-2"></i>Salir De La Cuenta</a></li>
                                        <li> <hr class="dropdown-divider"></li>

                                    </ul>
                                </li>
                            </ul>

                        </div>
                    </nav>
                    </header>
                    <main>

                        <section class="py-0">
                            <div class="container">
                                <div class="row mt-4 align-items-center">
                                    <div class="col-12">
                                        <div class="card bg-light overflow-hidden px-sm-5">
                                            <div class="row align-items-center g-4">

                                                <div class="col-sm-9">
                                                    <div class="card-body">
                                                        
                                                        <h1 class="m-0 h2 card-title">Confirmación del pago</h1>
                                                    </div>
                                                </div>

                                                <div class="col-sm-3 text-end d-none d-sm-block">
                                                    <img src="../../../assets/images/element/17.svg" class="mb-n4" alt="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <section>
                            <div class="container">
                                    <div class="bs-stepper-content p-0 pt-4">
                                        <div class="row g-4">

                                            <div class="col-xl-8">
                                                <form onsubmit="return false">

                                                    <div class="col--xl-8" aria-labelledby="steppertrigger1">
                                                        <div class="vstack gap-4">
                                                            <h4 class="mb-0">Revisión del servicio</h4>

                                                            <hr class="my-0">
                                                            <div class="card shadow rounded-2 overflow-hidden">
                                                                <div class="row g-0">
                                                                    <div class="col-sm-6 col-md-4">
                                                                        <img src="../../../assets/images/category/tour/4by3/03.jpg" class="" alt="">
                                                                    </div>

                                                                    <div class="col-sm-6 col-md-8">
                                                                        <div class="card-body p-3">
                                                                            <h5 class="card-title mb-1"><a href="#"><%= nombre%></a></h5>
                                                                            <ul class="list-inline mb-0">
                                                                                <li class="nav-item mb-1"><i class="breadcrumb-item active"></i><%= cat%></li>
                                                                            </ul>

                                                                            <ul class="nav nav-divider small mb-0 mt-2">
                                                                                <li class="nav-item mb-1"><i class="breadcrumb-item active"></i><%= desc%></li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="card border">
                                                                <div class="card-header border-bottom d-flex justify-content-between">
                                                                    <h5 class="mb-0">Detalles de la fecha</h5>
                                                                </div>

                                                                <div class="card-body">

                                                                    <div class="p-3 bg-light rounded-2 d-sm-flex justify-content-sm-between align-items-center mb-4">
                                                                        <h6 class="mb-0"><%= nombre%> - Viernes</h6>
                                                                        <h6 class="fw-normal mb-0"><span class="text-body">Fecha:</span> 5 septiembre 2023</h6>
                                                                    </div>

                                                                    <div class="row g-4">
                                                                        <div class="col-md-3">
                                                                            <img src="../../../assets/images/element/09.svg" class="w-80px mb-3" alt="">
                                                                        </div>

                                                                        <div class="col-4 col-md-3">
                                                                            <h5>Hora de inicio</h5>
                                                                            <h6 class="mb-0">2:50 pm</h6>
                                                                        </div>

                                                                        <div class="col-4 col-md-3 text-end">
                                                                            <h5>Hora de finalización</h5>
                                                                            <h6 class="mb-0">6:50</h6>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                            
                                                            
                                                        </div>
                                                    </div>
                                                    

                                                </form>
                                            </div>
                                            <aside class="col-xl-4">
                                                <div class="vstack gap-4">
                                                    <div class="card border">
                                                        <div class="card-header border-bottom">
                                                            <h5 class="card-title mb-0">Pago</h5>
                                                        </div>

                                                        <div class="card-body">
                                                            <ul class="list-group list-group-borderless">
                                                                <li class="list-group-item d-flex justify-content-between align-items-center pt-0">
                                                                    <span class="h6 fw-light mb-0">Costo</span>
                                                                    <span class="fs-5">$ <%= precio%></span>
                                                                </li>
                                  
                                                                <li class="list-group-item d-flex justify-content-between align-items-center pb-0">
                                                                    <span class="h6 fw-light mb-0">Impuestos y Pagos</span>
                                                                    <span class="fs-5">$30</span>
                                                                </li>
                                                            </ul>
                                                        </div>

                                                        <div class="card-footer border-top">
                                                            <div class="d-flex justify-content-between align-items-center">
                                                                <span class="h5 mb-0">Total</span>
                                                                <span class="h5 mb-0">$ <%= prS%></span>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                    
                                                            
                                                            
                                                    <div class="text-end">
                                                        <form method="GET" ">
                                                                <button  type="submit" id="pago" name="pago" value="pagar" class="btn btn-primary next-btn mb-0">Comprar</button>
                                                        </form>
                                                    </div>
                                                            
                                                    
                                                </div> 
                                            </aside>

                                        </div>

                                    </div>
                                </div>
                        </section>

                    </main>
                    <footer class="bg-dark pt-5">
                        <div class="container">
                            <div class="row g-4">

                                <div class="col-lg-3">
                                    <a href="../home-page.jsp">
                                        <img class="h-40px" src="../../../assets/images/logo-light.svg" alt="logo">
                                    </a>
                                    <p class="my-3 text-muted">"Demostrando que la Ciencia y la Tecnología son una rama más del Arte"</p>
                                    <p class="mb-2"><a href="#" class="text-muted text-primary-hover"><i class="bi bi-telephone me-2"></i> +52 1 55 5555 5555</a> </p>
                                    <p class="mb-0"><a href="#" class="text-muted text-primary-hover"><i class="bi bi-envelope me-2"></i>byron.inc.jdb@gmail.com</a></p>
                                </div>
                                <div class="col-lg-8 ms-auto">
                                    <div class="row g-4">
                                        <div class="col-6 col-md-4">
                                            <h5 class="text-white mb-2 mb-md-4">Páginas</h5>
                                            <ul class="nav flex-column text-primary-hover">
                                                <li class="nav-item"><a class="nav-link text-muted" href="../../Byron/about.html">Acerca De Nosotros</a></li>
                                                <li class="nav-item"><a class="nav-link text-muted" href="../../Byron/contact.jsp">Contáctanos</a></li>
                                            </ul>
                                        </div>

                                        <div class="col-6 col-md-5">
                                            <h5 class="text-white mb-2 mb-md-4">Links</h5>
                                            <ul class="nav flex-column text-primary-hover">
                                                <li class="nav-item"><a class="nav-link text-muted" href="../../Byron/privacy-policy.html">Políticas De Privacidad</a></li>
                                            </ul>
                                        </div>

                                        <div class="col-6 col-md-3">
                                            <h5 class="text-white mb-2 mb-md-4">Servicios</h5>
                                            <ul class="nav flex-column text-primary-hover">
                                                <li class="nav-item"><a class="nav-link text-muted" href="service-grid.jsp"><i class="bi bi-bucket-fill me-2"></i>Servicios</a>
                                                <li class="nav-item"><a class="nav-link text-muted" href="../../Generics/coming-soon.html"><i class="fa-solid fa-car me-2"></i>Transporte</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="row g-4 justify-content-between mt-0 mt-md-2">

                                <div class="col-sm-7 col-md-6 col-lg-4">
                                    <h5 class="text-white mb-2">Payment & Security</h5>
                                    <ul class="list-inline mb-0 mt-3">
                                        <li class="list-inline-item"> <a href="#"><img src="../../../assets/images/element/paypal.svg" class="h-30px" alt=""></a></li>
                                        <li class="list-inline-item"> <a href="#"><img src="../../../assets/images/element/visa.svg" class="h-30px" alt=""></a></li>
                                        <li class="list-inline-item"> <a href="#"><img src="../../../assets/images/element/mastercard.svg" class="h-30px" alt=""></a></li>
                                        <li class="list-inline-item"> <a href="#"><img src="../../../assets/images/element/expresscard.svg" class="h-30px" alt=""></a></li>
                                    </ul>
                                </div>

                                <div class="col-sm-5 col-md-6 col-lg-3 text-sm-end">
                                    <h5 class="text-white mb-2">Síguenos en</h5>
                                    <ul class="list-inline mb-0 mt-3">
                                        <li class="list-inline-item"> <a class="btn btn-sm px-2 bg-facebook mb-0" href="https://www.facebook.com/profile.php?id=100092532574820" target="_blank"><i class="fab fa-fw fa-facebook-f"></i></a> </li>
                                    </ul>	
                                </div>
                            </div>

                            <hr class="mt-4 mb-0">

                            <div class="row">
                                <div class="container">
                                    <div class="d-lg-flex justify-content-between align-items-center py-3 text-center text-lg-start">
                                        <div class="text-muted text-primary-hover"> Copyrights ©2023 Byron Inc</div>
                                        <div class="nav mt-2 mt-lg-0">
                                            <ul class="list-inline text-primary-hover mx-auto mb-0">
                                                <li class="list-inline-item me-0"><a class="nav-link py-1 text-muted" href="../../Byron/privacy-policy.html">Privacy policy</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </footer>
                    <div class="back-top"></div>

                    <script src="../../../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

                    <script src="../../../assets/vendor/choices/js/choices.min.js"></script>
                    <script src="../../../assets/vendor/flatpickr/js/flatpickr.min.js"></script>
                    <script src="../../../assets/vendor/stepper/js/bs-stepper.min.js"></script>

                    <script src="../../../assets/js/functions.js"></script>

    </body>
</html>