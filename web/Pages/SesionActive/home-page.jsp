

<%@page import="org.eServices.dao.Usuario"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services</title>

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

        <link rel="shortcut icon" href="../../assets/images/favicon.ico">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&family=Poppins:wght@400;500;700&display=swap">

        <link rel="stylesheet" type="text/css" href="../../assets/vendor/font-awesome/css/all.min.css">

        <link rel="stylesheet" type="text/css" href="../../assets/vendor/bootstrap-icons/bootstrap-icons.css">
        <link rel="stylesheet" type="text/css" href="../../assets/vendor/tiny-slider/tiny-slider.css">
        <link rel="stylesheet" type="text/css" href="../../assets/vendor/glightbox/css/glightbox.css">
        <link rel="stylesheet" type="text/css" href="../../assets/vendor/flatpickr/css/flatpickr.min.css">
        <link rel="stylesheet" type="text/css" href="../../assets/vendor/choices/css/choices.min.css">


        <link rel="stylesheet" type="text/css" href="../../assets/css/style.css">



    </head>
    
    
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
           


           if (nom == null){
           try {
            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection(url, usuario, contrasena);
            sentencia = conexion.createStatement();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
           
           
        
        
           
           String selectQuery2 = "SELECT nombre FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery2);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

             nom = "";
            
            
            if (resultSet.next()) {
                nom = resultSet.getString("nombre");
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
        }
        

    
    %>

    <body class="has-navbar-mobile">

        <header class="navbar-light header-sticky">
            <nav class="navbar navbar-expand-xl">
                <div class="container">
                    <a class="navbar-brand" href="home-page.jsp">
                        <img class="light-mode-item navbar-brand-item" src="../../assets/images/logo.svg" alt="logo">
                        <img class="dark-mode-item navbar-brand-item" src="../../assets/images/logo-light.svg" alt="logo">
                    </a>
                    

                    <button class="navbar-toggler ms-sm-auto mx-3 me-md-0 p-0 p-sm-2" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCategoryCollapse" aria-controls="navbarCategoryCollapse" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="bi bi-grid-3x3-gap-fill fa-fw"></i><span class="d-none d-sm-inline-block small">Category</span>
                    </button>

                    

                            
                            <div class="navbar-collapse collapse" id="navbarCategoryCollapse">
                                <ul class="navbar-nav navbar-nav-scroll nav-pills-primary-soft text-center ms-auto p-2 p-xl-0">
                                    <li class="nav-item"> <a class="nav-link" href="../SesionActive/eService/service-grid.jsp"><i class="bi bi-bucket-fill"></i>Servicios</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="../Generics/coming-soon.html"><i class="fa-solid fa-car fs-5"></i>Transporte</a></li>
                                </ul>
                            </div>
                            <ul class="nav flex-row align-items-center list-unstyled ms-xl-auto">
                                <li class="nav-item ms-3 dropdown">
                                    <a class="avatar avatar-sm p-0" href="#" id="profileDropdown" role="button" data-bs-auto-close="outside" data-bs-display="static" data-bs-toggle="dropdown" aria-expanded="false">
                                        <img class="avatar-img rounded-2" src="../../assets/images/avatar/01.jpg" alt="avatar">
                                    </a>

                                    <ul class="dropdown-menu dropdown-animation dropdown-menu-end shadow pt-3" aria-labelledby="profileDropdown">
                                        <li class="px-3 mb-3">
                                            <div class="d-flex align-items-center">
                                                <div class="avatar me-3">
                                                    <img class="avatar-img rounded-circle shadow" src="../../assets/images/avatar/01.jpg" alt="avatar">
                                                </div>
                                                <div>
                                                    <a class="h6 mt-2 mt-sm-0" href="#"><%= nom%></a>
                                                    <p class="small m-0"><%= email%></p>
                                                </div>
                                            </div>
                                        </li>

                                        <li> <hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="Cuenta/Cliente/account-bookings.jsp"><i class="bi bi-ticket-perforated fa-fw me-2"></i>Mis Servicios</a></li>
                                        <li><a class="dropdown-item bg-danger-soft-hover" href="../../index.html"><i class="bi bi-power fa-fw me-2"></i>Salir De La Cuenta</a></li>
                                        <li> <hr class="dropdown-divider"></li>

                                    </ul>
                                </li>
                            </ul>

                        </div>
                    </nav>
                </div>
            </nav>
        </header>
        <main>

            <section class="pt-3 pt-lg-5">
                <div class="container">
                    <div class="row g-4 g-lg-5">
                        <div class="col-lg-6 position-relative mb-4 mb-md-0">
                            <h1 class="mb-4 mt-md-5 display-5"> Encuentra asistencia
                                <span class="position-relative z-index-9"> eficiente.
                                    <span class="position-absolute top-50 start-50 translate-middle z-index-n1 d-none d-md-block mt-4">
                                        <svg width="390.5px" height="21.5px" viewBox="0 0 445.5 21.5">
                                        <path class="fill-primary opacity-7" d="M409.9,2.6c-9.7-0.6-19.5-1-29.2-1.5c-3.2-0.2-6.4-0.2-9.7-0.3c-7-0.2-14-0.4-20.9-0.5 c-3.9-0.1-7.8-0.2-11.7-0.3c-1.1,0-2.3,0-3.4,0c-2.5,0-5.1,0-7.6,0c-11.5,0-23,0-34.5,0c-2.7,0-5.5,0.1-8.2,0.1 c-6.8,0.1-13.6,0.2-20.3,0.3c-7.7,0.1-15.3,0.1-23,0.3c-12.4,0.3-24.8,0.6-37.1,0.9c-7.2,0.2-14.3,0.3-21.5,0.6 c-12.3,0.5-24.7,1-37,1.5c-6.7,0.3-13.5,0.5-20.2,0.9C112.7,5.3,99.9,6,87.1,6.7C80.3,7.1,73.5,7.4,66.7,8 C54,9.1,41.3,10.1,28.5,11.2c-2.7,0.2-5.5,0.5-8.2,0.7c-5.5,0.5-11,1.2-16.4,1.8c-0.3,0-0.7,0.1-1,0.1c-0.7,0.2-1.2,0.5-1.7,1 C0.4,15.6,0,16.6,0,17.6c0,1,0.4,2,1.1,2.7c0.7,0.7,1.8,1.2,2.7,1.1c6.6-0.7,13.2-1.5,19.8-2.1c6.1-0.5,12.3-1,18.4-1.6 c6.7-0.6,13.4-1.1,20.1-1.7c2.7-0.2,5.4-0.5,8.1-0.7c10.4-0.6,20.9-1.1,31.3-1.7c6.5-0.4,13-0.7,19.5-1.1c2.7-0.1,5.4-0.3,8.1-0.4 c10.3-0.4,20.7-0.8,31-1.2c6.3-0.2,12.5-0.5,18.8-0.7c2.1-0.1,4.2-0.2,6.3-0.2c11.2-0.3,22.3-0.5,33.5-0.8 c6.2-0.1,12.5-0.3,18.7-0.4c2.2-0.1,4.4-0.1,6.7-0.1c11.5-0.1,23-0.2,34.6-0.4c7.2-0.1,14.4-0.1,21.6-0.1c12.2,0,24.5,0.1,36.7,0.1 c2.4,0,4.8,0.1,7.2,0.2c6.8,0.2,13.5,0.4,20.3,0.6c5.1,0.2,10.1,0.3,15.2,0.4c3.6,0.1,7.2,0.4,10.8,0.6c10.6,0.6,21.1,1.2,31.7,1.8 c2.7,0.2,5.4,0.4,8,0.6c2.9,0.2,5.8,0.4,8.6,0.7c0.4,0.1,0.9,0.2,1.3,0.3c1.1,0.2,2.2,0.2,3.2-0.4c0.9-0.5,1.6-1.5,1.9-2.5 c0.6-2.2-0.7-4.5-2.9-5.2c-1.9-0.5-3.9-0.7-5.9-0.9c-1.4-0.1-2.7-0.3-4.1-0.4c-2.6-0.3-5.2-0.4-7.9-0.6 C419.7,3.1,414.8,2.9,409.9,2.6z"/>
                                        </svg>
                                    </span>
                                </span>
                            </h1>
                            <p class="mb-4">Enfocados en la seguridad y rapidez de tus servicios.</p>
                            
                            <div class="hstack gap-4 flex-wrap align-items-center">
                                <a href="../SesionActive/eService/service-grid.jsp" class="btn btn-primary-soft mb-0">Ver Servicios</a>

                                <div class="align-middle d-inline-block">
                                    <a href="../Byron/about.html" class="btn btn-primary-soft mb-0">Sobre Nosotros</a>
                                </div>

                            </div>
                            <br>
                        </div>

                        <div class="col-lg-6 position-relative">

                            <img src="../../assets/images/bg/06.jpg" class="rounded" alt="">

                            <figure class="position-absolute end-0 bottom-0">
                                <svg width="163px" height="163px" viewBox="0 0 163 163">
                                <path class="fill-warning" d="M145.6,66.2c-0.9-0.3-1.6,0.2-2.1-0.4c-0.5-0.7-1-1.5-1-2.4c0-3.1,0.1-6.2,0-9.3c0-0.7,0.3-1.3,0.5-1.9 c0.8-1.6,1.6-3.2,2.7-4.5c0.5-0.6,1.2-1.2,2-1.5c0.4-0.2,0.8,0.4,1.3-0.1c0.4-0.4,1,0.7,1.6,0.7c0.4,1-0.4,1.5-1,2.1 c0.7,0.3,1.4,0.3,2.1,0.7c0.6,0.4,1.2,0.7,1,1.5c-0.2,1,0.6,1.3,1,1.9c-0.2,0.3-0.6,0.4-0.5,0.8c1.2,3.2,0.3,5.4-0.7,8.1 c-0.3,0.7-0.7,1.6-0.7,2.2c-0.1,1.5-1.2,2.7-1.4,4.1c-0.2,1.1-0.9,1.7-2.1,1.6c-0.2,0-0.4,0.5-1,0.4c-0.2-0.2-0.7-0.5-0.7-0.8 c0-1-0.1-1.7-1.1-2.1C145.5,67.2,145.6,66.6,145.6,66.2"/>
                                <path class="fill-warning" d="M94.3,143.5c1.1,0.3,2.4-0.5,3.2,0.7c-0.4,0.7-0.7,1.4-1,2.1c0.5,0.5,0.7,0.2,1.2,0.1c1.6-0.6,2-0.4,2.5,1.2 c0.1,0.2,0,0.6,0.3,0.6c1.8,0.4,1.4,2.2,2.1,3.2c-0.8,0.9,0.5,1.8,0.1,2.6c-0.5,0.8-0.3,2-1.3,2.6c-0.3,0.2-0.1,0.5-0.2,0.7 c-0.3,2.1-1.2,3.7-3.4,4.4c-0.3,0.1-0.4,0.6-1,0.4c-0.3-0.6-0.6-1.3-1-1.9c-0.5-0.2-1.5,0.3-1.4-1h-3c-0.2-1.4,0-2.9-1.1-3.9 c-0.1-0.1-0.1-0.4,0-0.5c0.7-1.2,0.2-2.6,0.7-3.8c0.3-0.6,0.4-1,0.1-1.6c-0.9-1.3,0-2.4,0.7-3.3C92.5,145,93.4,144.3,94.3,143.5"/>
                                <path class="fill-warning" d="M119.6,77.3c-0.4,0.8-1.1,0.6-2,0.8c0.2,1.1-0.4,2.2,0.5,3.3c-0.8,0-0.8,0-1.2-0.3c-0.6,0.3-0.8,1-1.2,1.6 c0.1-1.9-0.6-3.2-2-4.1c-0.6-0.1-0.7,0.3-1,0.5c-1-1.9-1-2.8-0.2-7.7c0.4-2.5,1.7-4.6,3.6-6.8c0.6-0.1,1.5,1.5,2.3,0 c0.8,1.5-0.7,2.3-0.8,3.7c0.8-0.4,1.6-0.7,2.4-0.4c0.4,0.4-0.1,1,0.3,1.4c0.8,0.6,1.4,1.3,0.4,2.3c1.1,0.8-0.3,1.5-0.1,2.4 c0.2,0.8,0,1.7,0,2.5c-0.8-0.2-1-1.1-1.8-1C118.2,76.4,119.5,76.5,119.6,77.3"/>
                                <path class="fill-warning" d="M25,131c-0.3-0.6-1.2-0.3-1.7-0.5v-1.2c-0.1-0.1-0.1-0.2-0.2-0.2c-1.4,0.5-2.2-1-3.4-1.2 c-1.2-0.1-1.9-1-2.1-2.2c-0.1-0.5,0.1-0.8,0.5-1.1c-2-1.7-0.8-3.4-0.1-5.1c0.8-2.2,2.6-2.5,4.6-2.4c0.4,1.1,0.2,2-0.6,2.7 c1.5,1,2-0.5,3-0.8c0.3,0.6,0.6,1.2,0.9,1.6c0,0.6-0.8,0.8-0.4,1.4c0.7,0.8,0.9-0.5,1.7-0.3c1,0.9,0.9,2.2,0.8,3.4 c0.4,0.1,0.6,0.2,1,0.3c-0.1,0.6-1,0.8-1,1.5c0,0.8,0.8,0.2,1,0.7C27.7,128.8,26.9,130.3,25,131"/>
                                <path class="fill-warning" d="M84.9,95H87c0.4,0.4,0.3,1.6-0.3,2.8c1.2,1,1.7-0.5,2.4-0.8c0.8,0,0.8,0.6,1.2,0.7c0.2,0.8-0.7,0.9-0.4,1.7 c0.5,0.3,1.7,0,1.9,0.9c0.2,0.7,0.3,1.5-0.5,2.1c0.3,0.1,0.6,0.2,0.9,0.3c-0.1,0.7-1.1,1.3-0.5,2.2c-1.1,1.5-3,2.1-4.4,3.3 c-0.3,0.2-0.8,1-1.5,0.5c-0.3-0.4,0.4-0.4,0.3-0.8c-0.7-0.5-1.6,0.1-2.4-0.3c-0.2-0.6,0.1-1.4-0.8-1.8c-1.1,0.5-2.2,0.7-3.2-0.8 c1.3-0.8,3-1.1,3.2-3c-1,0-1.7,0.9-2.7,1c-0.2-0.2-0.5-0.4-0.8-0.7c-0.1-0.1,0.1-0.1,0.2-0.3c0.6-1.1,2.4-1,2.5-2.5 c1.2-0.5,1.1-1.7,1.3-2.5C83.8,96.3,84.3,95.7,84.9,95"/>
                                <path class="fill-warning" d="M41.2,153.9c0.3-0.7,0.9-0.8,0.4-1.6c-0.3-0.3-1.1,0.2-1.8-0.2c0-0.2-0.1-0.4-0.1-0.7c-0.1-0.1-0.2-0.2-0.3,0 c-0.3,0.4-0.7,0.4-1.1,0.4c-1.3,0-1.5-0.4-1.6-1.7c0-0.6,0.4-0.8,0.5-1.4c-0.4,0-0.8-0.1-1.4-0.1c-0.4-1.9,0.7-3.6,1.1-5.4 c0.2-0.9,1.6-1.3,2.7-1.3c0.4,0.2,0.3,0.6,0.3,0.7c0.2,0.4,0.3,0.3,0.4,0.1c0.6-0.5,1.3-0.6,1.7,0.1c0.5,0.7,1.1,0.6,1.8,0.7 c0.4,0.4,0.1,0.8,0.2,1.2c0.3,0.4,0.8,0.2,1.3,0.3c1,0.7,0.5,2.1,1.3,2.9C43.8,152.3,43.1,153.1,41.2,153.9"/>
                                <path class="fill-warning" d="M70.9,43.4c-0.3-1.4-1.2-1.8-2.6-1.5c-1.2-2.3-0.8-4.8-0.5-7.2c0.1-0.5,0.4-1.1,0.3-1.7 c-0.2-1.1,0.5-1.9,0.6-2.9c0.1-0.7,1.3-0.9,2-1.3c0.9,0.8,0.9,0.8,1.2,2c0.3,0,0.6,0,0.4,0c1.3,0,0.8,0.9,1.3,1.2 c0.3,0.1,0.8,0.5,0.7,1c-0.2,0.8,1,1.4,0.5,2.1c-0.5,0.7-0.2,1.5-0.5,2.1c-0.8,1.5-1,3.2-1.5,4.8C72.6,43.1,72,43.4,70.9,43.4"/>
                                <path class="fill-warning" d="M125.4,118.4c-0.4-0.3-0.6-0.7-1.3-0.8c-1.6-0.1-1.6-0.2-1.9-1.9c-1.1-0.4-2.2,0-3.2,0.4 c-0.5-0.5-0.2-0.9-0.4-1.4c0.4-0.1,0.7-0.2,1-0.4v-3c-0.5,0.2-1,0.3-1.7,0.5c-0.3,0-0.4-0.6-0.8-0.7c0.6-1.5,1.8-2.4,2.8-3.5 c1.3,0.3,2.6-1.1,3.8,0.4c0,0.1-0.1,1.8,0,2.1c-0.2,0-0.5,0.1-0.7,0.1c-0.2,0-0.3,0-0.5,0c-0.4,0.4-0.1,1.1-0.7,1.5 c1.3-0.5,2.4-1,3.3-2c0.4,0.4,0.7,0.8,1.4,0.6c-1.1,0.9,0.4,2.1-1,2.9c1,0,1.1-0.6,1.5-0.8c0.4-0.1,0.8-0.1,1.2-0.2 c0.5,1,1.1,1.8,0.6,3c-0.7,0.6-2.2,0.4-2.5,2.1c1.2-0.2,1.9-0.9,2.5-1.5c0.7,0.1,0.7,0.5,0.6,0.8c-1.3-0.1-1.2,1.5-2.3,1.9 c-0.9,0.3-1.6,1-2.7,1.8C124.7,119.5,125.1,119,125.4,118.4"/>
                                <path class="fill-warning" d="M101.7,41c-0.3,0.3-0.6,0.6-0.9,0.9c0.9,0.6-0.9,1.6,0.4,2.1c-2,2.3-2,2.4-2.1,4.8h-2.4c-0.2-0.1,0-0.5-0.2-0.8 c-2.4-0.3-2.9-0.8-3-3.3c0-0.6,0.2-1.4-0.5-1.8c0.5-0.7,0.2-1.6,0.7-2.4c1-1.5,2.3-2.7,3.5-3.9c0.5-0.2,1-0.1,1.4,0 c0.2,1-1.1,1.6-0.2,2.6c0.3-0.4,0.6-0.8,0.9-1.3C100.2,39.2,101.7,39.5,101.7,41"/>
                                <path class="fill-warning" d="M140.4,5.4c-0.4,0.6-1.2-0.1-1.5,0.6c0.7,0.4,1.5,0.1,2.3,0.2c0.3,1.1,0.9,2.1,1.3,3.2c0.9,2.4,0.3,4.4-0.6,6.6 c-0.4,0.9-0.9,1.2-1.9,1c-0.2-0.5-0.5-1.2-0.9-1.9c-0.6-0.2-1.5,0-1.9-1c0.1-1.7,0.1-3.6-1.1-5.2c0.4-0.7,0.7-1.3,1.1-1.9 c-0.3-0.1-0.6-0.2-1-0.4c0.2-0.8,0.5-1.6,1.3-2.3h2.2C140,4.6,140.5,4.8,140.4,5.4"/>
                                <path class="fill-warning" d="M65.7,68.8c-0.4,0.6-0.9,0.4-1.4,0.4c-1.2-1.1-0.4-2.9-1.4-4.1c1.5-3,1.5-3,4.1-4.2c0.5,0.1,0.8,0.5,1,1 c0.1,0.6-0.8,0.7-0.5,1.3c0.5,0.6,0.9,0.2,1.2-0.2c1.5,0.6,1.1,2.5,2.4,3.3c-0.1,1.1,0.2,2.2-0.2,3.2L69,72.2c-0.3,0-0.7,0-1,0 c-0.3-0.5-0.9-2.2-0.8-2.4C66.7,69.6,66.2,69.2,65.7,68.8"/>
                                <path class="fill-warning" d="M37.5,69.7c-0.5,0.2,0,0.9-0.4,1c-0.7,0.2-1-0.2-1.2-0.6c-0.4-0.7,0.1-1.6-0.2-2.2c-0.5-0.7-0.6-1.2-0.1-2 c0.5-0.6,0.2-1.5,0.6-2.3c0.9-2,0.9-2.1,3-2.1c0.1,0.1,0.2,0.1,0.2,0.2c0,0.3,0,0.7,0,1.1c0.7,0.4,1.7,0.1,2.1,1.3 c0.3,0.9,1.2,1.5,1,2.7c-0.2,0.9,0.1,1.8-0.8,2.5c-0.4,0.4-0.8,1.1-0.8,2c0,0.6-0.5,1-1.2,1.1c-0.6,0.1-1-0.3-1.2-0.7 C38,71,37.8,70.3,37.5,69.7"/>
                                <path class="fill-warning" d="M53.9,87.8c0.7,0,1.4,0,2.1,0c0.5,0.3,0.1,1,0.4,1.4c0.4,0.3,0.8,0.1,1.2,0.2c0.6,1.2,1.4,2.4,1.7,3.6 c0.4,1.4-0.2,2.7-0.7,4c-1,0.4-1.5-0.4-2.1-0.9c-0.7,0-1.4,0-2.1,0c-0.4-1-0.8-1.8-2.1-1.5c-0.6-0.7,0.2-1.8-0.7-2.3 c0.5-0.6,0.9-1.3,1-2.1C52.8,89.2,53.2,88.5,53.9,87.8"/>
                                <path class="fill-warning" d="M0.1,95.7c0.9-1.3,2.3-1.7,3.8-1.8c1,1.2-0.7,1.5-0.8,2.3c1.1,1,2-0.7,3.1,0c0.6,0.6-0.2,0.8-0.3,1.2 c0.4,0.5,1,0,1.4,0.3c0.4,1.1-0.3,2.3,0.6,3.3c-0.8,0.8-0.7,2.2-1.9,2.8c-1.1-0.2-1.8-1-2.6-1.7c-0.7-0.6-1.9-0.5-2.6-1.9 C1,98.9-0.4,97.4,0.1,95.7"/>
                                <path class="fill-warning" d="M155.5,91.5c-0.9-0.5-1.7-0.7-2.3-1.6c0.4-0.2,0.8-0.5,1.2-0.7c-1.2-0.4-2.1,0.7-3.1,0c0.6-1,1.8-1,2.5-1.7 c0.1-0.6-0.3-0.6-0.7-0.7c-0.7-0.2-0.9,0.9-1.6,0.5c-0.3-0.3-0.4-0.7-0.1-0.9c1.7-1,3-2.3,4.5-3.5c0.9-0.7,1.1-0.9,2.5-1.2 c-0.1,0.5-0.6,0.7-0.9,1.1c0.7,0.7,1.3,0.1,1.9-0.2c0.1,1.1,0.9,1.9,0.5,3.4C158.3,87.4,157.4,89.8,155.5,91.5"/>
                                </svg>
                            </figure>

                            <div class="position-absolute top-0 end-0 z-index-1 mt-n4">
                                <div class="bg-blur border border-light rounded-3 text-center shadow-lg p-3">
                                    <i class="bi bi-headset text-danger fs-3"></i>
                                    <h5 class="text-dark mb-1">24 / 7</h5>
                                    <h6 class="text-dark fw-light small mb-0">Soporte en linea</h6>
                                </div>
                            </div>

                            <div class="vstack gap-5 align-items-center position-absolute top-0 start-0 d-none d-md-flex mt-4 ms-n3">
                                <img class="icon-lg shadow-lg border border-3 border-white rounded-circle" src="../../assets/images/category/hotel/4by3/11.jpg" alt="avatar">
                                <img class="icon-xl shadow-lg border border-3 border-white rounded-circle" src="../../assets/images/category/hotel/4by3/12.jpg" alt="avatar">
                            </div>
                        </div>
                    </div>
                    

                    <div class="row">
                        
                           
                        </div>
                    </div>
                    
            </section>
            <section class="pb-0 pb-xl-5">
                <div class="container">
                    <div class="row g-4 justify-content-between align-items-center">
                        <div class="col-lg-5 position-relative">
                            <figure class="position-absolute top-0 start-0 translate-middle z-index-1 ms-4">
                                <svg class="fill-warning" width="77px" height="77px">
                                <path d="M76.997,41.258 L45.173,41.258 L67.676,63.760 L63.763,67.673 L41.261,45.171 L41.261,76.994 L35.728,76.994 L35.728,45.171 L13.226,67.673 L9.313,63.760 L31.816,41.258 L-0.007,41.258 L-0.007,35.725 L31.816,35.725 L9.313,13.223 L13.226,9.311 L35.728,31.813 L35.728,-0.010 L41.261,-0.010 L41.261,31.813 L63.763,9.311 L67.676,13.223 L45.174,35.725 L76.997,35.725 L76.997,41.258 Z"/>
                                </svg>
                            </figure>

                            <figure class="position-absolute bottom-0 end-0 d-none d-md-block mb-n5 me-n4">
                                <svg height="400" class="fill-primary opacity-2" viewBox="0 0 340 340">
                                <circle cx="194.2" cy="2.2" r="2.2"></circle>
                                <circle cx="2.2" cy="2.2" r="2.2"></circle>
                                <circle cx="218.2" cy="2.2" r="2.2"></circle>
                                <circle cx="26.2" cy="2.2" r="2.2"></circle>
                                <circle cx="242.2" cy="2.2" r="2.2"></circle>
                                <circle cx="50.2" cy="2.2" r="2.2"></circle>
                                <circle cx="266.2" cy="2.2" r="2.2"></circle>
                                <circle cx="74.2" cy="2.2" r="2.2"></circle>
                                <circle cx="290.2" cy="2.2" r="2.2"></circle>
                                <circle cx="98.2" cy="2.2" r="2.2"></circle>
                                <circle cx="314.2" cy="2.2" r="2.2"></circle>
                                <circle cx="122.2" cy="2.2" r="2.2"></circle>
                                <circle cx="338.2" cy="2.2" r="2.2"></circle>
                                <circle cx="146.2" cy="2.2" r="2.2"></circle>
                                <circle cx="170.2" cy="2.2" r="2.2"></circle>
                                <circle cx="194.2" cy="26.2" r="2.2"></circle>
                                <circle cx="2.2" cy="26.2" r="2.2"></circle>
                                <circle cx="218.2" cy="26.2" r="2.2"></circle>
                                <circle cx="26.2" cy="26.2" r="2.2"></circle>
                                <circle cx="242.2" cy="26.2" r="2.2"></circle>
                                <circle cx="50.2" cy="26.2" r="2.2"></circle>
                                <circle cx="266.2" cy="26.2" r="2.2"></circle>
                                <circle cx="74.2" cy="26.2" r="2.2"></circle>
                                <circle cx="290.2" cy="26.2" r="2.2"></circle>
                                <circle cx="98.2" cy="26.2" r="2.2"></circle>
                                <circle cx="314.2" cy="26.2" r="2.2"></circle>
                                <circle cx="122.2" cy="26.2" r="2.2"></circle>
                                <circle cx="338.2" cy="26.2" r="2.2"></circle>
                                <circle cx="146.2" cy="26.2" r="2.2"></circle>
                                <circle cx="170.2" cy="26.2" r="2.2"></circle>
                                <circle cx="194.2" cy="50.2" r="2.2"></circle>
                                <circle cx="2.2" cy="50.2" r="2.2"></circle>
                                <circle cx="218.2" cy="50.2" r="2.2"></circle>
                                <circle cx="26.2" cy="50.2" r="2.2"></circle>
                                <circle cx="242.2" cy="50.2" r="2.2"></circle>
                                <circle cx="50.2" cy="50.2" r="2.2"></circle>
                                <circle cx="266.2" cy="50.2" r="2.2"></circle>
                                <circle cx="74.2" cy="50.2" r="2.2"></circle>
                                <circle cx="290.2" cy="50.2" r="2.2"></circle>
                                <circle cx="98.2" cy="50.2" r="2.2"></circle>
                                <circle cx="314.2" cy="50.2" r="2.2"></circle>
                                <circle cx="122.2" cy="50.2" r="2.2"></circle>
                                <circle cx="338.2" cy="50.2" r="2.2"></circle>
                                <circle cx="146.2" cy="50.2" r="2.2"></circle>
                                <circle cx="170.2" cy="50.2" r="2.2"></circle>
                                <circle cx="194.2" cy="74.2" r="2.2"></circle>
                                <circle cx="2.2" cy="74.2" r="2.2"></circle>
                                <circle cx="218.2" cy="74.2" r="2.2"></circle>
                                <circle cx="26.2" cy="74.2" r="2.2"></circle>
                                <circle cx="242.2" cy="74.2" r="2.2"></circle>
                                <circle cx="50.2" cy="74.2" r="2.2"></circle>
                                <circle cx="266.2" cy="74.2" r="2.2"></circle>
                                <circle cx="74.2" cy="74.2" r="2.2"></circle>
                                <circle cx="290.2" cy="74.2" r="2.2"></circle>
                                <circle cx="98.2" cy="74.2" r="2.2"></circle>
                                <circle cx="314.2" cy="74.2" r="2.2"></circle>
                                <circle cx="122.2" cy="74.2" r="2.2"></circle>
                                <circle cx="338.2" cy="74.2" r="2.2"></circle>
                                <circle cx="146.2" cy="74.2" r="2.2"></circle>
                                <circle cx="170.2" cy="74.2" r="2.2"></circle>
                                <circle cx="194.2" cy="98.2" r="2.2"></circle>
                                <circle cx="2.2" cy="98.2" r="2.2"></circle>
                                <circle cx="218.2" cy="98.2" r="2.2"></circle>
                                <circle cx="26.2" cy="98.2" r="2.2"></circle>
                                <circle cx="242.2" cy="98.2" r="2.2"></circle>
                                <circle cx="50.2" cy="98.2" r="2.2"></circle>
                                <circle cx="266.2" cy="98.2" r="2.2"></circle>
                                <circle cx="74.2" cy="98.2" r="2.2"></circle>
                                <circle cx="290.2" cy="98.2" r="2.2"></circle>
                                <circle cx="98.2" cy="98.2" r="2.2"></circle>
                                <circle cx="314.2" cy="98.2" r="2.2"></circle>
                                <circle cx="122.2" cy="98.2" r="2.2"></circle>
                                <circle cx="338.2" cy="98.2" r="2.2"></circle>
                                <circle cx="146.2" cy="98.2" r="2.2"></circle>
                                <circle cx="170.2" cy="98.2" r="2.2"></circle>
                                <circle cx="194.2" cy="122.2" r="2.2"></circle>
                                <circle cx="2.2" cy="122.2" r="2.2"></circle>
                                <circle cx="218.2" cy="122.2" r="2.2"></circle>
                                <circle cx="26.2" cy="122.2" r="2.2"></circle>
                                <circle cx="242.2" cy="122.2" r="2.2"></circle>
                                <circle cx="50.2" cy="122.2" r="2.2"></circle>
                                <circle cx="266.2" cy="122.2" r="2.2"></circle>
                                <circle cx="74.2" cy="122.2" r="2.2"></circle>
                                <circle cx="290.2" cy="122.2" r="2.2"></circle>
                                <circle cx="98.2" cy="122.2" r="2.2"></circle>
                                <circle cx="314.2" cy="122.2" r="2.2"></circle>
                                <circle cx="122.2" cy="122.2" r="2.2"></circle>
                                <circle cx="338.2" cy="122.2" r="2.2"></circle>
                                <circle cx="146.2" cy="122.2" r="2.2"></circle>
                                <circle cx="170.2" cy="122.2" r="2.2"></circle>
                                <circle cx="194.2" cy="146.2" r="2.2"></circle>
                                <circle cx="2.2" cy="146.2" r="2.2"></circle>
                                <circle cx="218.2" cy="146.2" r="2.2"></circle>
                                <circle cx="26.2" cy="146.2" r="2.2"></circle>
                                <circle cx="242.2" cy="146.2" r="2.2"></circle>
                                <circle cx="50.2" cy="146.2" r="2.2"></circle>
                                <circle cx="266.2" cy="146.2" r="2.2"></circle>
                                <circle cx="74.2" cy="146.2" r="2.2"></circle>
                                <circle cx="290.2" cy="146.2" r="2.2"></circle>
                                <circle cx="98.2" cy="146.2" r="2.2"></circle>
                                <circle cx="314.2" cy="146.2" r="2.2"></circle>
                                <circle cx="122.2" cy="146.2" r="2.2"></circle>
                                <circle cx="338.2" cy="146.2" r="2.2"></circle>
                                <circle cx="146.2" cy="146.2" r="2.2"></circle>
                                <circle cx="170.2" cy="146.2" r="2.2"></circle>
                                <circle cx="194.2" cy="170.2" r="2.2"></circle>
                                <circle cx="2.2" cy="170.2" r="2.2"></circle>
                                <circle cx="218.2" cy="170.2" r="2.2"></circle>
                                <circle cx="26.2" cy="170.2" r="2.2"></circle>
                                <circle cx="242.2" cy="170.2" r="2.2"></circle>
                                <circle cx="50.2" cy="170.2" r="2.2"></circle>
                                <circle cx="266.2" cy="170.2" r="2.2"></circle>
                                <circle cx="74.2" cy="170.2" r="2.2"></circle>
                                <circle cx="290.2" cy="170.2" r="2.2"></circle>
                                <circle cx="98.2" cy="170.2" r="2.2"></circle>
                                <circle cx="314.2" cy="170.2" r="2.2"></circle>
                                <circle cx="122.2" cy="170.2" r="2.2"></circle>
                                <circle cx="338.2" cy="170.2" r="2.2"></circle>
                                <circle cx="146.2" cy="170.2" r="2.2"></circle>
                                <circle cx="170.2" cy="170.2" r="2.2"></circle>
                                <circle cx="194.2" cy="194.2" r="2.2"></circle>
                                <circle cx="2.2" cy="194.2" r="2.2"></circle>
                                <circle cx="218.2" cy="194.2" r="2.2"></circle>
                                <circle cx="26.2" cy="194.2" r="2.2"></circle>
                                <circle cx="242.2" cy="194.2" r="2.2"></circle>
                                <circle cx="50.2" cy="194.2" r="2.2"></circle>
                                <circle cx="266.2" cy="194.2" r="2.2"></circle>
                                <circle cx="74.2" cy="194.2" r="2.2"></circle>
                                <circle cx="290.2" cy="194.2" r="2.2"></circle>
                                <circle cx="98.2" cy="194.2" r="2.2"></circle>
                                <circle cx="314.2" cy="194.2" r="2.2"></circle>
                                <circle cx="122.2" cy="194.2" r="2.2"></circle>
                                <circle cx="338.2" cy="194.2" r="2.2"></circle>
                                <circle cx="146.2" cy="194.2" r="2.2"></circle>
                                <circle cx="170.2" cy="194.2" r="2.2"></circle>
                                <circle cx="194.2" cy="218.2" r="2.2"></circle>
                                <circle cx="2.2" cy="218.2" r="2.2"></circle>
                                <circle cx="218.2" cy="218.2" r="2.2"></circle>
                                <circle cx="26.2" cy="218.2" r="2.2"></circle>
                                <circle cx="242.2" cy="218.2" r="2.2"></circle>
                                <circle cx="50.2" cy="218.2" r="2.2"></circle>
                                <circle cx="266.2" cy="218.2" r="2.2"></circle>
                                <circle cx="74.2" cy="218.2" r="2.2"></circle>
                                <circle cx="290.2" cy="218.2" r="2.2"></circle>
                                <circle cx="98.2" cy="218.2" r="2.2"></circle>
                                <circle cx="314.2" cy="218.2" r="2.2"></circle>
                                <circle cx="122.2" cy="218.2" r="2.2"></circle>
                                <circle cx="338.2" cy="218.2" r="2.2"></circle>
                                <circle cx="146.2" cy="218.2" r="2.2"></circle>
                                <circle cx="170.2" cy="218.2" r="2.2"></circle>
                                <circle cx="194.2" cy="242.2" r="2.2"></circle>
                                <circle cx="2.2" cy="242.2" r="2.2"></circle>
                                <circle cx="218.2" cy="242.2" r="2.2"></circle>
                                <circle cx="26.2" cy="242.2" r="2.2"></circle>
                                <circle cx="242.2" cy="242.2" r="2.2"></circle>
                                <circle cx="50.2" cy="242.2" r="2.2"></circle>
                                <circle cx="266.2" cy="242.2" r="2.2"></circle>
                                <circle cx="74.2" cy="242.2" r="2.2"></circle>
                                <circle cx="290.2" cy="242.2" r="2.2"></circle>
                                <circle cx="98.2" cy="242.2" r="2.2"></circle>
                                <circle cx="314.2" cy="242.2" r="2.2"></circle>
                                <circle cx="122.2" cy="242.2" r="2.2"></circle>
                                <circle cx="338.2" cy="242.2" r="2.2"></circle>
                                <circle cx="146.2" cy="242.2" r="2.2"></circle>
                                <circle cx="170.2" cy="242.2" r="2.2"></circle>
                                <circle cx="194.2" cy="266.2" r="2.2"></circle>
                                <circle cx="2.2" cy="266.2" r="2.2"></circle>
                                <circle cx="218.2" cy="266.2" r="2.2"></circle>
                                <circle cx="26.2" cy="266.2" r="2.2"></circle>
                                <circle cx="242.2" cy="266.2" r="2.2"></circle>
                                <circle cx="50.2" cy="266.2" r="2.2"></circle>
                                <circle cx="266.2" cy="266.2" r="2.2"></circle>
                                <circle cx="74.2" cy="266.2" r="2.2"></circle>
                                <circle cx="290.2" cy="266.2" r="2.2"></circle>
                                <circle cx="98.2" cy="266.2" r="2.2"></circle>
                                <circle cx="314.2" cy="266.2" r="2.2"></circle>
                                <circle cx="122.2" cy="266.2" r="2.2"></circle>
                                <circle cx="338.2" cy="266.2" r="2.2"></circle>
                                <circle cx="146.2" cy="266.2" r="2.2"></circle>
                                <circle cx="170.2" cy="266.2" r="2.2"></circle>
                                <circle cx="194.2" cy="290.2" r="2.2"></circle>
                                <circle cx="2.2" cy="290.2" r="2.2"></circle>
                                <circle cx="218.2" cy="290.2" r="2.2"></circle>
                                <circle cx="26.2" cy="290.2" r="2.2"></circle>
                                <circle cx="242.2" cy="290.2" r="2.2"></circle>
                                <circle cx="50.2" cy="290.2" r="2.2"></circle>
                                <circle cx="266.2" cy="290.2" r="2.2"></circle>
                                <circle cx="74.2" cy="290.2" r="2.2"></circle>
                                <circle cx="290.2" cy="290.2" r="2.2"></circle>
                                <circle cx="98.2" cy="290.2" r="2.2"></circle>
                                <circle cx="314.2" cy="290.2" r="2.2"></circle>
                                <circle cx="122.2" cy="290.2" r="2.2"></circle>
                                <circle cx="338.2" cy="290.2" r="2.2"></circle>
                                <circle cx="146.2" cy="290.2" r="2.2"></circle>
                                <circle cx="170.2" cy="290.2" r="2.2"></circle>
                                <circle cx="194.2" cy="314.2" r="2.2"></circle>
                                <circle cx="2.2" cy="314.2" r="2.2"></circle>
                                <circle cx="218.2" cy="314.2" r="2.2"></circle>
                                <circle cx="26.2" cy="314.2" r="2.2"></circle>
                                <circle cx="242.2" cy="314.2" r="2.2"></circle>
                                <circle cx="50.2" cy="314.2" r="2.2"></circle>
                                <circle cx="266.2" cy="314.2" r="2.2"></circle>
                                <circle cx="74.2" cy="314.2" r="2.2"></circle>
                                <circle cx="290.2" cy="314.2" r="2.2"></circle>
                                <circle cx="98.2" cy="314.2" r="2.2"></circle>
                                <circle cx="314.2" cy="314.2" r="2.2"></circle>
                                <circle cx="122.2" cy="314.2" r="2.2"></circle>
                                <circle cx="338.2" cy="314.2" r="2.2"></circle>
                                <circle cx="146.2" cy="314.2" r="2.2"></circle>
                                <circle cx="170.2" cy="314.2" r="2.2"></circle>
                                <circle cx="194.2" cy="338.2" r="2.2"></circle>
                                <circle cx="2.2" cy="338.2" r="2.2"></circle>
                                <circle cx="218.2" cy="338.2" r="2.2"></circle>
                                <circle cx="26.2" cy="338.2" r="2.2"></circle>
                                <circle cx="242.2" cy="338.2" r="2.2"></circle>
                                <circle cx="50.2" cy="338.2" r="2.2"></circle>
                                <circle cx="266.2" cy="338.2" r="2.2"></circle>
                                <circle cx="74.2" cy="338.2" r="2.2"></circle>
                                <circle cx="290.2" cy="338.2" r="2.2"></circle>
                                <circle cx="98.2" cy="338.2" r="2.2"></circle>
                                <circle cx="314.2" cy="338.2" r="2.2"></circle>
                                <circle cx="122.2" cy="338.2" r="2.2"></circle>
                                <circle cx="338.2" cy="338.2" r="2.2"></circle>
                                <circle cx="146.2" cy="338.2" r="2.2"></circle>
                                <circle cx="170.2" cy="338.2" r="2.2"></circle>
                                </svg>
                            </figure>

                            <img src="../../assets/images/about/01.jpg" class="rounded-3 position-relative" alt="">

                            <div class="position-absolute bottom-0 start-0 z-index-1 mb-4 ms-5">
                                <div class="bg-body d-flex d-inline-block rounded-3 position-relative p-3">	

                                    <img src="../../assets/images/element/01.svg" class="position-absolute top-0 start-0 translate-middle w-40px" alt="">

                                    <div class="me-4">
                                        <h6 class="fw-light">Clientes</h6>
                                        <ul class="avatar-group mb-0">
                                            <li class="avatar avatar-sm">
                                                <img class="avatar-img rounded-circle" src="../../assets/images/avatar/01.jpg" alt="avatar">
                                            </li>
                                            <li class="avatar avatar-sm">
                                                <img class="avatar-img rounded-circle" src="../../assets/images/avatar/02.jpg" alt="avatar">
                                            </li>
                                            <li class="avatar avatar-sm">
                                                <img class="avatar-img rounded-circle" src="../../assets/images/avatar/03.jpg" alt="avatar">
                                            </li>
                                            <li class="avatar avatar-sm">
                                                <img class="avatar-img rounded-circle" src="../../assets/images/avatar/04.jpg" alt="avatar">
                                            </li>
                                            <li class="avatar avatar-sm">
                                                <div class="avatar-img rounded-circle bg-primary">
                                                    <span class="text-white position-absolute top-50 start-50 translate-middle small">1K+</span>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>

                                    <div>
                                        <h6 class="fw-light mb-3">Reseña</h6>
                                        <h6 class="m-0">4.5<i class="fa-solid fa-star text-warning ms-1"></i></h6>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <h2 class="mb-3 mb-lg-5">¡Los mejores servicios para ti!</h2>
                            <p class="mb-3 mb-lg-5">Contrata asistencia flexible y cómoda.</p>

                            <div class="row g-4">
                                <div class="col-sm-6">
                                    <div class="icon-lg bg-danger bg-opacity-10 text-danger rounded-circle"><i class="bi bi-stopwatch-fill"></i></div>
                                    <h5 class="mt-2">Servicios rápidos</h5>
                                    <p class="mb-0">Facilitamos la buscqueda de asistencia en línea.</p>
                                </div>
                                <div class="col-sm-6">
                                    <div class="icon-lg bg-orange bg-opacity-10 text-orange rounded-circle"><i class="bi bi-shield-fill-check"></i></div>
                                    <h5 class="mt-2">Alta seguridad</h5>
                                    <p class="mb-0">Garantizamos tus servicios.</p>
                                </div>
                                <div class="col-sm-6">
                                    <div class="icon-lg bg-info bg-opacity-10 text-info rounded-circle"><i class="bi bi-lightning-fill"></i></div>
                                    <h5 class="mt-2">Alerta las 24 horas</h5>
                                    <p class="mb-0">Monitoreamos tus necesidades las 24 horas día.</p>
                                </div>		
                            </div>

                        </div>
                    </div>
                </div>
            </section>

            
            <section class="pb-0 py-md-5">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-11 mx-auto">
                            <div class="tiny-slider arrow-round arrow-border arrow-hover">
                                <div class="tiny-slider-inner" data-edge="2" data-items="1">

                                    <div class="px-4 px-md-5">
                                        <div class="row justify-content-between align-items-center">

                                            <div class="col-md-6 col-lg-5 position-relative">
                                                <div class="position-absolute top-0 start-0 translate-middle z-index-9 mt-7 ms-4">
                                                    <img src="../../assets/images/element/02.svg" class="h-60px bg-orange rounded p-2" alt="">
                                                </div>

                                                <figure class="position-absolute bottom-0 end-0 d-none d-sm-block mb-n5 me-n5">
                                                    <svg width="326px" height="335px" viewBox="0 0 326 335">
                                                    <path class="fill-primary opacity-1" d="M7.3,0C3.3,0,0,3.3,0,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.6,3.3,11.3,0,7.3,0z
                                                          M59.2,0.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.5,4,63.2,0.7,59.2,0.7L59.2,0.7z	M111.1,1.5c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.4,4.7,115.1,1.5,111.1,1.5 C111.1,1.5,111.1,1.5,111.1,1.5L111.1,1.5z M163,2.2c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C170.3,5.5,167,2.2,163,2.2C163,2.2,163,2.2,163,2.2L163,2.2z M214.9,2.9c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3 c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.2,6.2,218.9,2.9,214.9,2.9C214.9,2.9,214.9,2.9,214.9,2.9L214.9,2.9z M266.8,3.7 c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.1,6.9,270.8,3.7,266.8,3.7C266.8,3.7,266.8,3.7,266.8,3.7L266.8,3.7z M318.7,4.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326,7.7,322.7,4.4,318.7,4.4C318.7,4.4,318.7,4.4,318.7,4.4L318.7,4.4z M7.3,52.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.6,55.9,11.4,52.7,7.3,52.7C7.3,52.7,7.3,52.7,7.3,52.7L7.3,52.7z M59.2,53.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.5,56.7,63.3,53.4,59.2,53.4C59.2,53.4,59.2,53.4,59.2,53.4L59.2,53.4z M111.1,54.1c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.4,57.4,115.2,54.1,111.1,54.1C111.1,54.1,111.1,54.1,111.1,54.1L111.1,54.1z M163,54.9c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C170.3,58.1,167.1,54.9,163,54.9C163,54.9,163,54.9,163,54.9L163,54.9zM214.9,55.6c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.2,58.9,219,55.6,214.9,55.6C214.9,55.6,214.9,55.6,214.9,55.6L214.9,55.6z M266.8,56.3c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.1,59.6,270.9,56.3,266.8,56.3C266.8,56.3,266.8,56.3,266.8,56.3L266.8,56.3z M318.7,57c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326,60.3,322.8,57.1,318.7,57C318.7,57,318.7,57,318.7,57L318.7,57zM7.3,105.3c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.7,108.6,11.4,105.3,7.3,105.3C7.3,105.3,7.3,105.3,7.3,105.3L7.3,105.3z M59.2,106c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.6,109.3,63.3,106.1,59.2,106C59.2,106,59.2,106,59.2,106L59.2,106z M111.1,106.8c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.5,110.1,115.2,106.8,111.1,106.8C111.1,106.8,111.1,106.8,111.1,106.8L111.1,106.8zM163,107.5c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C170.4,110.8,167.1,107.5,163,107.5C163,107.5,163,107.5,163,107.5L163,107.5z M214.9,108.2c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.3,111.5,219,108.3,214.9,108.2C214.9,108.2,214.9,108.3,214.9,108.2L214.9,108.2z M266.8,109c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.2,112.3,270.9,109,266.8,109C266.8,109,266.8,109,266.8,109L266.8,109zM318.7,109.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326.1,113,322.8,109.7,318.7,109.7C318.7,109.7,318.7,109.7,318.7,109.7L318.7,109.7z M7.3,158c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.6,161.3,11.3,158,7.3,158z M59.2,158.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.5,162,63.2,158.7,59.2,158.7C59.2,158.7,59.2,158.7,59.2,158.7L59.2,158.7z M111.1,159.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.4,162.7,115.1,159.5,111.1,159.4C111.1,159.4,111.1,159.4,111.1,159.4L111.1,159.4z M163,160.2c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C170.3,163.5,167,160.2,163,160.2C163,160.2,163,160.2,163,160.2L163,160.2z M214.9,160.9c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.2,164.2,218.9,160.9,214.9,160.9C214.9,160.9,214.9,160.9,214.9,160.9L214.9,160.9zM266.8,161.6c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.1,164.9,270.8,161.6,266.8,161.6C266.8,161.6,266.8,161.6,266.8,161.6L266.8,161.6z M318.7,162.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326,165.6,322.7,162.4,318.7,162.4C318.7,162.4,318.7,162.4,318.7,162.4L318.7,162.4z M7.3,210.6c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.6,213.9,11.4,210.7,7.3,210.6C7.3,210.6,7.3,210.6,7.3,210.6L7.3,210.6zM59.2,211.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.5,214.7,63.3,211.4,59.2,211.4C59.2,211.4,59.2,211.4,59.2,211.4L59.2,211.4z M111.1,212.1c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.4,215.4,115.2,212.1,111.1,212.1C111.1,212.1,111.1,212.1,111.1,212.1L111.1,212.1z M163,212.8c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C170.3,216.1,167.1,212.8,163,212.8C163,212.8,163,212.8,163,212.8L163,212.8z M214.9,213.6c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.2,216.8,219,213.6,214.9,213.6C214.9,213.6,214.9,213.6,214.9,213.6L214.9,213.6z M266.8,214.3c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.1,217.6,270.9,214.3,266.8,214.3C266.8,214.3,266.8,214.3,266.8,214.3L266.8,214.3z M318.7,215c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326,218.3,322.8,215,318.7,215C318.7,215,318.7,215,318.7,215L318.7,215z M7.3,263.3c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.7,266.6,11.4,263.3,7.3,263.3C7.3,263.3,7.3,263.3,7.3,263.3L7.3,263.3z M59.2,264c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.6,267.3,63.3,264,59.2,264C59.2,264,59.2,264,59.2,264L59.2,264z M111.1,264.8c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.5,268,115.2,264.8,111.1,264.8C111.1,264.8,111.1,264.8,111.1,264.8L111.1,264.8z M163,265.5c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C170.4,268.8,167.1,265.5,163,265.5C163,265.5,163,265.5,163,265.5L163,265.5z M214.9,266.2c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.3,269.5,219,266.2,214.9,266.2C214.9,266.2,214.9,266.2,214.9,266.2L214.9,266.2z M266.8,267c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.2,270.2,270.9,267,266.8,267C266.8,267,266.8,267,266.8,267L266.8,267z M318.7,267.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326.1,271,322.8,267.7,318.7,267.7C318.7,267.7,318.7,267.7,318.7,267.7L318.7,267.7z M7.4,316c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.7,319.2,11.4,316,7.4,316C7.3,316,7.3,316,7.4,316L7.4,316z M59.3,316.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.6,320,63.3,316.7,59.3,316.7C59.2,316.7,59.2,316.7,59.3,316.7L59.3,316.7z M111.2,317.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.5,320.7,115.2,317.4,111.2,317.4C111.1,317.4,111.1,317.4,111.2,317.4L111.2,317.4z M163.1,318.2c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C170.4,321.4,167.1,318.2,163.1,318.2C163,318.2,163,318.2,163.1,318.2L163.1,318.2z M215,318.9c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.3,322.2,219,318.9,215,318.9C214.9,318.9,214.9,318.9,215,318.9L215,318.9z M266.9,319.6c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.2,322.9,270.9,319.6,266.9,319.6C266.8,319.6,266.8,319.6,266.9,319.6L266.9,319.6z M318.8,320.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326.1,323.6,322.8,320.4,318.8,320.4C318.7,320.4,318.7,320.4,318.8,320.4L318.8,320.4z"/>
                                                    </svg>
                                                </figure>

                                                <img src="../../assets/images/team/01.jpg" class="rounded-3 position-relative" alt="">
                                            </div>

                                            <div class="col-md-6 col-lg-6">
                                                <span class="display-3 mb-0 text-primary"><i class="bi bi-quote"></i></span>
                                                <h5 class="fw-light">eServices es el mejor lugar para contratar servicios, con total seguridad y calidad.</h5>
                                                <h6 class="mb-0">Uraga</h6>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="px-4 px-md-5">
                                        <div class="row justify-content-between align-items-center">

                                            <div class="col-md-6 col-lg-5 position-relative">
                                                <div class="position-absolute top-0 start-0 translate-middle mt-7 ms-4 z-index-9">
                                                    <img src="../../assets/images/element/03.svg" class="h-60px bg-orange p-2 rounded" alt="">
                                                </div>

                                                <figure class="position-absolute bottom-0 end-0 mb-n5 me-n5 d-none d-sm-block">
                                                    <svg width="326px" height="335px" viewBox="0 0 326 335">
                                                    <path class="fill-primary opacity-1" d="M7.3,0C3.3,0,0,3.3,0,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.6,3.3,11.3,0,7.3,0z M59.2,0.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.5,4,63.2,0.7,59.2,0.7L59.2,0.7z M111.1,1.5c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.4,4.7,115.1,1.5,111.1,1.5 C111.1,1.5,111.1,1.5,111.1,1.5L111.1,1.5z M163,2.2c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C170.3,5.5,167,2.2,163,2.2C163,2.2,163,2.2,163,2.2L163,2.2z M214.9,2.9c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3 c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.2,6.2,218.9,2.9,214.9,2.9C214.9,2.9,214.9,2.9,214.9,2.9L214.9,2.9z M266.8,3.7 c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.1,6.9,270.8,3.7,266.8,3.7 C266.8,3.7,266.8,3.7,266.8,3.7L266.8,3.7z M318.7,4.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C326,7.7,322.7,4.4,318.7,4.4C318.7,4.4,318.7,4.4,318.7,4.4L318.7,4.4z M7.3,52.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3 c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.6,55.9,11.4,52.7,7.3,52.7C7.3,52.7,7.3,52.7,7.3,52.7L7.3,52.7z M59.2,53.4 c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.5,56.7,63.3,53.4,59.2,53.4 C59.2,53.4,59.2,53.4,59.2,53.4L59.2,53.4z M111.1,54.1c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C118.4,57.4,115.2,54.1,111.1,54.1C111.1,54.1,111.1,54.1,111.1,54.1L111.1,54.1z M163,54.9c-4,0-7.3,3.3-7.3,7.3 c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C170.3,58.1,167.1,54.9,163,54.9C163,54.9,163,54.9,163,54.9L163,54.9z M214.9,55.6c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.2,58.9,219,55.6,214.9,55.6 C214.9,55.6,214.9,55.6,214.9,55.6L214.9,55.6z M266.8,56.3c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3 c0,0,0,0,0,0C274.1,59.6,270.9,56.3,266.8,56.3C266.8,56.3,266.8,56.3,266.8,56.3L266.8,56.3z M318.7,57c-4,0-7.3,3.3-7.3,7.3 c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326,60.3,322.8,57.1,318.7,57C318.7,57,318.7,57,318.7,57L318.7,57z M7.3,105.3c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.7,108.6,11.4,105.3,7.3,105.3 C7.3,105.3,7.3,105.3,7.3,105.3L7.3,105.3z M59.2,106c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C66.6,109.3,63.3,106.1,59.2,106C59.2,106,59.2,106,59.2,106L59.2,106z M111.1,106.8c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3 c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.5,110.1,115.2,106.8,111.1,106.8C111.1,106.8,111.1,106.8,111.1,106.8L111.1,106.8z M163,107.5c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C170.4,110.8,167.1,107.5,163,107.5 C163,107.5,163,107.5,163,107.5L163,107.5z M214.9,108.2c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C222.3,111.5,219,108.3,214.9,108.2C214.9,108.2,214.9,108.3,214.9,108.2L214.9,108.2z M266.8,109c-4,0-7.3,3.3-7.3,7.3 c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.2,112.3,270.9,109,266.8,109C266.8,109,266.8,109,266.8,109L266.8,109z M318.7,109.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326.1,113,322.8,109.7,318.7,109.7 C318.7,109.7,318.7,109.7,318.7,109.7L318.7,109.7z M7.3,158c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3 c0,0,0,0,0,0C14.6,161.3,11.3,158,7.3,158z M59.2,158.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C66.5,162,63.2,158.7,59.2,158.7C59.2,158.7,59.2,158.7,59.2,158.7L59.2,158.7z M111.1,159.4c-4,0-7.3,3.3-7.3,7.3 c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.4,162.7,115.1,159.5,111.1,159.4C111.1,159.4,111.1,159.4,111.1,159.4 L111.1,159.4z M163,160.2c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C170.3,163.5,167,160.2,163,160.2C163,160.2,163,160.2,163,160.2L163,160.2z M214.9,160.9c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3 c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.2,164.2,218.9,160.9,214.9,160.9C214.9,160.9,214.9,160.9,214.9,160.9L214.9,160.9z M266.8,161.6c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.1,164.9,270.8,161.6,266.8,161.6 C266.8,161.6,266.8,161.6,266.8,161.6L266.8,161.6z M318.7,162.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3 c0,0,0,0,0,0C326,165.6,322.7,162.4,318.7,162.4C318.7,162.4,318.7,162.4,318.7,162.4L318.7,162.4z M7.3,210.6c-4,0-7.3,3.3-7.3,7.3 c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.6,213.9,11.4,210.7,7.3,210.6C7.3,210.6,7.3,210.6,7.3,210.6L7.3,210.6z M59.2,211.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.5,214.7,63.3,211.4,59.2,211.4 C59.2,211.4,59.2,211.4,59.2,211.4L59.2,211.4z M111.1,212.1c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3 c0,0,0,0,0,0C118.4,215.4,115.2,212.1,111.1,212.1C111.1,212.1,111.1,212.1,111.1,212.1L111.1,212.1z M163,212.8 c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C170.3,216.1,167.1,212.8,163,212.8 C163,212.8,163,212.8,163,212.8L163,212.8z M214.9,213.6c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C222.2,216.8,219,213.6,214.9,213.6C214.9,213.6,214.9,213.6,214.9,213.6L214.9,213.6z M266.8,214.3c-4,0-7.3,3.3-7.3,7.3 c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.1,217.6,270.9,214.3,266.8,214.3C266.8,214.3,266.8,214.3,266.8,214.3 L266.8,214.3z M318.7,215c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326,218.3,322.8,215,318.7,215 C318.7,215,318.7,215,318.7,215L318.7,215z M7.3,263.3c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C14.7,266.6,11.4,263.3,7.3,263.3C7.3,263.3,7.3,263.3,7.3,263.3L7.3,263.3z M59.2,264c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3 c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.6,267.3,63.3,264,59.2,264C59.2,264,59.2,264,59.2,264L59.2,264z M111.1,264.8 c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C118.5,268,115.2,264.8,111.1,264.8 C111.1,264.8,111.1,264.8,111.1,264.8L111.1,264.8z M163,265.5c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3 c0,0,0,0,0,0C170.4,268.8,167.1,265.5,163,265.5C163,265.5,163,265.5,163,265.5L163,265.5z M214.9,266.2c-4,0-7.3,3.3-7.3,7.3 c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C222.3,269.5,219,266.2,214.9,266.2C214.9,266.2,214.9,266.2,214.9,266.2 L214.9,266.2z M266.8,267c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0 C274.2,270.2,270.9,267,266.8,267C266.8,267,266.8,267,266.8,267L266.8,267z M318.7,267.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3 c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C326.1,271,322.8,267.7,318.7,267.7C318.7,267.7,318.7,267.7,318.7,267.7L318.7,267.7z M7.4,316 c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C14.7,319.2,11.4,316,7.4,316C7.3,316,7.3,316,7.4,316 L7.4,316z M59.3,316.7c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C66.6,320,63.3,316.7,59.3,316.7 C59.2,316.7,59.2,316.7,59.3,316.7L59.3,316.7z M111.2,317.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3 c0,0,0,0,0,0C118.5,320.7,115.2,317.4,111.2,317.4C111.1,317.4,111.1,317.4,111.2,317.4L111.2,317.4z M163.1,318.2 c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C170.4,321.4,167.1,318.2,163.1,318.2 C163,318.2,163,318.2,163.1,318.2L163.1,318.2z M215,318.9c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3 c0,0,0,0,0,0C222.3,322.2,219,318.9,215,318.9C214.9,318.9,214.9,318.9,215,318.9L215,318.9z M266.9,319.6c-4,0-7.3,3.3-7.3,7.3 c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0C274.2,322.9,270.9,319.6,266.9,319.6C266.8,319.6,266.8,319.6,266.9,319.6 L266.9,319.6z M318.8,320.4c-4,0-7.3,3.3-7.3,7.3c0,4,3.3,7.3,7.3,7.3c4,0,7.3-3.3,7.3-7.3c0,0,0,0,0,0
                                                          C326.1,323.6,322.8,320.4,318.8,320.4C318.7,320.4,318.7,320.4,318.8,320.4L318.8,320.4z"/>
                                                    </svg>
                                                </figure>

                                                <img src="../../assets/images/team/02.jpg" class="rounded-3 position-relative" alt="">
                                            </div>

                                            <div class="col-md-6 col-lg-6">
                                                <span class="display-3 mb-0 text-primary"><i class="bi bi-quote"></i></span>
                                                <h5 class="fw-light">El servicio es muy bueno y los trabajadores muy buenos en los que hacen, puntualidad y eficiencia lo mejor del servicio.</h5>
                                                <h6 class="mb-0">de la Riva</h6>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>	
                        </div>
                    </div>
                </div>
            </section>
            <section class="bg-light">
                <div class="container">
                    <div class="row g-4">

                        <div class="col-md-6 col-xxl-4">
                            <div class="bg-body d-flex rounded-3 h-100 p-4">
                                <h3><i class="fa-solid fa-hand-holding-heart"></i></h3>
                                <div class="ms-3">
                                    <h5>24x7 Help</h5>
                                    <p class="mb-0">Asistencia y soporte en línea.</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xxl-4">
                            <div class="bg-body d-flex rounded-3 h-100 p-4">
                                <h3><i class="fa-solid fa-hand-holding-usd"></i></h3>
                                <div class="ms-3">
                                    <h5>Pagos Confiables</h5>
                                    <p class="mb-0">Formas de pago por Internet sin tarjeta hasta pago a través de plataformas de pago.</p>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </section>

        </main>

        <footer class="bg-dark pt-5">
            <div class="container">
                <div class="row g-4">

                    <div class="col-lg-3">
                        <a href="home-page.jsp">
                            <img class="h-40px" src="../../assets/images/logo-light.svg" alt="logo">
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
                                    <li class="nav-item"><a class="nav-link text-muted" href="../Byron/about.html">Acerca De Nosotros</a></li>
                                    <li class="nav-item"><a class="nav-link text-muted" href="../Byron/contact.jsp">Contáctanos</a></li>
                                </ul>
                            </div>

                            <div class="col-6 col-md-5">
                                <h5 class="text-white mb-2 mb-md-4">Links</h5>
                                <ul class="nav flex-column text-primary-hover">
                                    <li class="nav-item"><a class="nav-link text-muted" href="../Byron/privacy-policy.html">Políticas De Privacidad</a></li>
                                </ul>
                            </div>

                            <div class="col-6 col-md-3">
                                <h5 class="text-white mb-2 mb-md-4">Servicios</h5>
                                <ul class="nav flex-column text-primary-hover">
                                    <li class="nav-item"><a class="nav-link text-muted" href="../SesionActive/eService/service-grid.jsp"><i class="bi bi-bucket-fill me-2"></i>Servicios</a>
                                    <li class="nav-item"><a class="nav-link text-muted" href="../Generics/coming-soon.html"><i class="fa-solid fa-car me-2"></i>Transporte</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row g-4 justify-content-between mt-0 mt-md-2">

                    <div class="col-sm-7 col-md-6 col-lg-4">
                        <h5 class="text-white mb-2">Payment & Security</h5>
                        <ul class="list-inline mb-0 mt-3">
                            <li class="list-inline-item"> <a href="#"><img src="../../assets/images/element/paypal.svg" class="h-30px" alt=""></a></li>
                            <li class="list-inline-item"> <a href="#"><img src="../../assets/images/element/visa.svg" class="h-30px" alt=""></a></li>
                            <li class="list-inline-item"> <a href="#"><img src="../../assets/images/element/mastercard.svg" class="h-30px" alt=""></a></li>
                            <li class="list-inline-item"> <a href="#"><img src="../../assets/images/element/expresscard.svg" class="h-30px" alt=""></a></li>
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
                                    <li class="list-inline-item me-0"><a class="nav-link py-1 text-muted" href="../Byron/privacy-policy.html">Privacy policy</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <div class="back-top"></div>

        

        <script src="../../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

        <script src="../../assets/vendor/tiny-slider/tiny-slider.js"></script>
        <script src="../../assets/vendor/glightbox/js/glightbox.js"></script>
        <script src="../../assets/vendor/flatpickr/js/flatpickr.min.js"></script>
        <script src="../../assets/vendor/choices/js/choices.min.js"></script>

        <script src="../../assets/js/functions.js"></script>

    </body>
</html>