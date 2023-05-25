<%@page import="org.eServices.dao.Tarjeta"%>
<%@page import="org.eServices.dao.Usuario"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services - Métodos de pago</title>

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

        <link rel="stylesheet" type="text/css" href="../../../../assets/css/style.css">

    </head>

    <body class="dashboard">
        
        
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
                
                
                String accion = request.getParameter("accion");
                     if ("Guardar".equals(accion)) {

                         String num_tarjeta = request.getParameter("num");
                         String ano = request.getParameter("ano");
                         String mes = request.getParameter("mes");
                         String cvv = request.getParameter("cvv");
                         String nombre_tar = request.getParameter("nom");

                         System.out.println(num_tarjeta);
                         System.out.println(ano);
                         System.out.println(mes);
                         System.out.println(cvv);
                         System.out.println(nombre_tar);

                         String consulta = "INSERT INTO Tarjeta (num_tarjeta, ano, mes, cvv, nombre_tar) VALUES ('" + num_tarjeta + "', '" + ano + "', '" + mes + "', '" + cvv + "', '" + nombre_tar + "')";

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

                         String consulta3 = "INSERT INTO usuario_tarjeta (id_usuario, num_tarjeta) VALUES ('" + id + "', '" + num_tarjeta + "')";

                         try {
                             sentencia.executeUpdate(consulta3);
                         } catch (SQLException e) {
                             e.printStackTrace();
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

                    String query = "SELECT num_tarjeta FROM usuario_tarjeta WHERE id_usuario = ?";
                    statement = conexion.prepareStatement(query);
                    statement.setInt(1, id);
                    resultSet = statement.executeQuery();

                    ArrayList<Integer> idS = new ArrayList<>();

                    while (resultSet.next()) {
                        int x = resultSet.getInt("num_tarjeta");
                        idS.add(x);
                    }

                    ArrayList<Tarjeta> tarjetas = new ArrayList<>();

                    for (int i = 0; i < idS.size(); i++) {
                        String selectQuery2 = "SELECT * FROM Tarjeta WHERE num_tarjeta = ?";
                        statement = conexion.prepareStatement(selectQuery2);
                        statement.setInt(1, idS.get(i));
                        resultSet = statement.executeQuery();

                        if (resultSet.next()) {
                            Tarjeta tarjeta = new Tarjeta();
                            tarjeta.setAno(resultSet.getString("ano"));
                            tarjeta.setCvv(resultSet.getString("cvv"));
                            tarjeta.setMes(resultSet.getString("mes"));
                            tarjeta.setNombre_tar(resultSet.getString("nombre_tar"));
                            tarjeta.setNum_tarjeta(resultSet.getString("num_tarjeta"));
                            
                            
                            
                            tarjetas.add(tarjeta);
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
        

        <header class="navbar-light header-sticky">
            <nav class="navbar navbar-expand-xl">
                <div class="container">
                    <a class="navbar-brand" href="../../home-page.jsp">
                        <img class="light-mode-item navbar-brand-item" src="../../../../assets/images/logo.svg" alt="logo">
                        <img class="dark-mode-item navbar-brand-item" src="../../../../assets/images/logo-light.svg" alt="logo">
                    </a>
                    <button class="navbar-toggler ms-sm-auto mx-3 me-md-0 p-0 p-sm-2" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCategoryCollapse" aria-controls="navbarCategoryCollapse" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="bi bi-grid-3x3-gap-fill fa-fw"></i><span class="d-none d-sm-inline-block small">Category</span>
                    </button>

                    
                            <div class="navbar-collapse collapse" id="navbarCategoryCollapse">
                                <ul class="navbar-nav navbar-nav-scroll nav-pills-primary-soft text-center ms-auto p-2 p-xl-0">
                                    <li class="nav-item"> <a class="nav-link" href="../../eService/service-grid.jsp"><i class="bi bi-bucket-fill"></i>Servicios</a></li>

                                    <li class="nav-item"> <a class="nav-link" href="../../../Generics/coming-soon.html"><i class="fa-solid fa-car fs-5"></i>Transporte</a></li>
                                </ul>
                            </div>
                            <ul class="nav flex-row align-items-center list-unstyled ms-xl-auto">
                                <li class="nav-item ms-3 dropdown">
                                    <a class="avatar avatar-sm p-0" href="#" id="profileDropdown" role="button" data-bs-auto-close="outside" data-bs-display="static" data-bs-toggle="dropdown" aria-expanded="false">
                                        <img class="avatar-img rounded-2" src="../../../../assets/images/avatar/01.jpg" alt="avatar">
                                    </a>

                                    <ul class="dropdown-menu dropdown-animation dropdown-menu-end shadow pt-3" aria-labelledby="profileDropdown">
                                        <li class="px-3 mb-3">
                                            <div class="d-flex align-items-center">
                                                <div class="avatar me-3">
                                                    <img class="avatar-img rounded-circle shadow" src="../../../../assets/images/avatar/01.jpg" alt="avatar">
                                                </div>
                                                <div>
                                                    <a class="h6 mt-2 mt-sm-0" href="#"><%= nom%></a>
                                                    <p class="small m-0"><%= email%></p>
                                                </div>
                                            </div>
                                        </li>

                                        <li> <hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="account-bookings.jsp"><i class="bi bi-ticket-perforated fa-fw me-2"></i>Mis Servicios</a></li>
                                        <li><a class="dropdown-item bg-danger-soft-hover" href="../../../../index.html"><i class="bi bi-power fa-fw me-2"></i>Salir De La Cuenta</a></li>
                                        <li> <hr class="dropdown-divider"></li>

                                    </ul>
                                </li>
                            </ul>

                        </div>
                    </nav>
                    </header>
                    <main>

                        <section class="pt-3">
                            <div class="container">
                                <div class="row g-2 g-lg-4">

                                    <div class="col-lg-4 col-xl-3">
                                        <div class="offcanvas-lg offcanvas-end" tabindex="-1" id="offcanvasSidebar">
                                            <div class="offcanvas-header justify-content-end pb-2">
                                                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#offcanvasSidebar" aria-label="Close"></button>
                                            </div>

                                            <div class="offcanvas-body p-3 p-lg-0">
                                                <div class="card bg-light w-100">

                                                    <div class="position-absolute top-0 end-0 p-3">
                                                        <a href="#" class="text-primary-hover" data-bs-toggle="tooltip" data-bs-title="Edit profile">
                                                            <i class="bi bi-pencil-square"></i>
                                                        </a>
                                                    </div>

                                                    <div class="card-body p-3">
                                                        <div class="text-center mb-3">
                                                            <div class="avatar avatar-xl mb-2">
                                                                <img class="avatar-img rounded-circle border border-2 border-white" src="../../../../assets/images/avatar/01.jpg" alt="">
                                                            </div>
                                                            <h6 class="mb-0"><%= nom%></h6>
                                                            <a href="#" class="text-reset text-primary-hover small"><%= email %></a>
                                                            <hr>
                                                        </div>

                                                        <ul class="nav nav-pills-primary-soft flex-column">
                                                            <li class="nav-item">
                                                                <a class="nav-link" href="account-profile.jsp"><i class="bi bi-person fa-fw me-2"></i>Mi Perfil</a>
                                                            </li>
                                                            <li class="nav-item">
                                                                <a class="nav-link " href="account-bookings.jsp"><i class="bi bi-ticket-perforated fa-fw me-2"></i>Mis servicios</a>
                                                            </li>
                                                            <li class="nav-item">
                                                                <a class="nav-link active" href="account-payment-details.jsp"><i class="bi bi-wallet fa-fw me-2"></i>Detalles de pago</a>
                                                            </li>
                                                            <li class="nav-item">
                                                                <a class="nav-link" href="account-delete.jsp"><i class="bi bi-trash fa-fw me-2"></i>Eliminar perfil</a>
                                                            </li>
                                                            <li class="nav-item">
                                                                <a class="nav-link text-danger bg-danger-soft-hover" href="../../../../index.html"><i class="fas fa-sign-out-alt fa-fw me-2"></i>Sign Out</a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-8 col-xl-9 ps-xl-5">

                                        <div class="d-grid mb-0 d-lg-none w-100">
                                            <button class="btn btn-primary mb-4" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasSidebar" aria-controls="offcanvasSidebar">
                                                <i class="fas fa-sliders-h"></i> Menu
                                            </button>
                                        </div>

                                        <div class="card bg-transparent border">
                                            <div class="card-header bg-transparent border-bottom">
                                                <h4 class="card-header-title">Detalles de pago</h4>
                                            </div>
                                            
                                            
                                            
                                            
                                            <div class="card border mt-4">
                                                    <div class="card-header border-bottom">
                                                        <h5 class="card-header-title">Agregar Nueva Tarjeta</h5>
                                                    </div>

                                                    <div class="card-body">
                                                        <form class="row text-start g-4">
                                                            <div class="col-12">
                                                                <label class="form-label">Número de Tarjeta<span class="text-danger">*</span></label>
                                                                <div class="position-relative">
                                                                    <input type="text" class="form-control" id ="num" name="num" placeholder="xxxx xxxx xxxx xxxx">
                                                                    <img src="../../../../assets/images/element/visa.svg" class="w-40px position-absolute top-50 end-0 translate-middle-y me-2 d-none d-sm-block" alt="">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label">Fecha de Caducación<span class="text-danger">*</span></label>
                                                                <div class="input-group">
                                                                    <input type="text" class="form-control" maxlength="2"  id ="mes" name="mes" placeholder="Mes">
                                                                    <input type="text" class="form-control" maxlength="4" id ="ano" name="ano" placeholder="Año">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label">CVV<span class="text-danger">*</span></label>
                                                                <input type="text" class="form-control" maxlength="3" id ="cvv" name="cvv" placeholder="xxx">
                                                            </div>
                                                            <div class="col-12">
                                                                <label class="form-label">Nombre de la Tarjeta<span class="text-danger">*</span></label>
                                                                <input type="text" class="form-control" aria-label="name of card holder" id ="nom" name="nom" placeholder="Enter name">
                                                            </div>
                                                            <div class="col-12">
                                                                <button type="submit" class="btn btn-primary mb-0" name = "accion" id="accion"  value ="Guardar">Agregar Tarjeta</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            
                                            
                                            <div class="card-body p-2 p-sm-4">
                                                <h5>Tarjetas Registradas</h5>

                                     <%
                                     
                                     
                                     for (int i = 0; i < tarjetas.size(); i++) {
                                     
                                     String num = tarjetas.get(i).getNum_tarjeta();
                                     String ano = tarjetas.get(i).getAno();
                                     String mes = tarjetas.get(i).getMes();
                                     
                                             
                                         
                                     
                                     %>

                                            
                                                
                                                <div style="margin: 10px;" class="row g-4">
                                                    <div class="col-md-6">
                                                        <div class="card">
                                                            <div class="bg-primary p-4 rounded-3">
                                                                <div class="d-flex justify-content-between align-items-start">
                                                                    <img class="w-40px" src="../../../../assets/images/element/visa.svg" alt="">
                                                                    <div class="dropdown">
                                                                        <a class="text-white" href="#" id="creditcardDropdown" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
                                                                            <svg width="24" height="24" fill="none">
                                                                            <circle fill="currentColor" cx="12.5" cy="3.5" r="2.5"></circle>
                                                                            <circle fill="currentColor" opacity="0.5" cx="12.5" cy="11.5" r="2.5"></circle>
                                                                            <circle fill="currentColor" opacity="0.3" cx="12.5" cy="19.5" r="2.5"></circle>
                                                                            </svg>
                                                                        </a>
                                                                      
                                                                    </div>
                                                                </div>
                                                                <h4 class="text-white mt-4"><%= num%></h4>
                                                                <div class="d-flex justify-content-between text-white">
                                                                    <span>Vigencia: <%= mes%>/<%= ano%></span>
                                                                    <span>CVV: ***</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                              
                                                
                                                
                 
                                  <%
                                  
                                      }
                                  %>              
                                                        
                                                        
                                              </div>            
                                                        
                                                

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
                                    <a href="../../home-page.jsp">
                                        <img class="h-40px" src="../../../../assets/images/logo-light.svg" alt="logo">
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
                                                <li class="nav-item"><a class="nav-link text-muted" href="../../../Byron/about.html">Acerca De Nosotros</a></li>
                                                <li class="nav-item"><a class="nav-link text-muted" href="../../../Byron/contact.jsp">Contáctanos</a></li>
                                            </ul>
                                        </div>

                                        <div class="col-6 col-md-5">
                                            <h5 class="text-white mb-2 mb-md-4">Links</h5>
                                            <ul class="nav flex-column text-primary-hover">
                                                <li class="nav-item"><a class="nav-link text-muted" href="../../../Byron/privacy-policy.html">Políticas De Privacidad</a></li>
                                            </ul>
                                        </div>

                                        <div class="col-6 col-md-3">
                                            <h5 class="text-white mb-2 mb-md-4">Servicios</h5>
                                            <ul class="nav flex-column text-primary-hover">
                                                <li class="nav-item"><a class="nav-link text-muted" href="../../eService/service-grid.jsp"><i class="bi bi-bucket-fill me-2"></i>Servicios</a>
                                                <li class="nav-item"><a class="nav-link text-muted" href="../../../Generics/coming-soon.html"><i class="fa-solid fa-car me-2"></i>Transporte</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="row g-4 justify-content-between mt-0 mt-md-2">

                                <div class="col-sm-7 col-md-6 col-lg-4">
                                    <h5 class="text-white mb-2">Payment & Security</h5>
                                    <ul class="list-inline mb-0 mt-3">
                                        <li class="list-inline-item"> <a href="#"><img src="../../../../assets/images/element/paypal.svg" class="h-30px" alt=""></a></li>
                                        <li class="list-inline-item"> <a href="#"><img src="../../../../assets/images/element/visa.svg" class="h-30px" alt=""></a></li>
                                        <li class="list-inline-item"> <a href="#"><img src="../../../../assets/images/element/mastercard.svg" class="h-30px" alt=""></a></li>
                                        <li class="list-inline-item"> <a href="#"><img src="../../../../assets/images/element/expresscard.svg" class="h-30px" alt=""></a></li>
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
                                                <li class="list-inline-item me-0"><a class="nav-link py-1 text-muted" href="../../../Generics/coming-soon.html">Privacy policy</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </footer>
                    <div class="back-top"></div>

                    <script src="../../../../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

                    <script src="../../../../assets/js/functions.js"></script>

    </body>
</html>