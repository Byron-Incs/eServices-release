<%@page import="org.eServices.dao.Servicio"%>
<%@page import="org.eServices.dao.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services - Servicios</title>

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
			if(el !== 'undefined' && el !== null) {
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
        <link rel="stylesheet" type="text/css" href="../../../assets/vendor/flatpickr/css/flatpickr.min.css">
        <link rel="stylesheet" type="text/css" href="../../../assets/vendor/choices/css/choices.min.css">
        <link rel="stylesheet" type="text/css" href="../../../assets/vendor/tiny-slider/tiny-slider.css">
        <link rel="stylesheet" type="text/css" href="../../../assets/vendor/nouislider/nouislider.css">

        <link rel="stylesheet" type="text/css" href="../../../assets/css/style.css">

    </head>

    <body>
        
        
        <%
        
        
    HttpSession sesion = request.getSession();
    Usuario user = (Usuario) session.getAttribute("user");
    
           String email = user.getEmail();
           String nom = user.getNombre_usuario();
           



                 String url = "jdbc:mysql://localhost:3306/eservices";
            String usuario = "root";
            String contrasena = "1234";

                 Connection conexion = null;
                 Statement sentencia = null;

                 PreparedStatement statement = null;
                 ResultSet resultSet = null;

                 ArrayList<Servicio> services = new ArrayList<>();
                 
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



                     String consulta2 = "SELECT * FROM Servicio";
                     resultSet = sentencia.executeQuery(consulta2);

                     while (resultSet.next()) {
                         Servicio service = new Servicio();
 
                 service.setCategoria(resultSet.getString("categoria"));
                 service.setDescripcionS(resultSet.getString("descripcionS"));
                 service.setNombreS(resultSet.getString("nombreS"));
                 service.setPrecio(resultSet.getString("precio"));
                 

                         services.add(service);
                     }
                     
                     System.out.println(services.size());


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
                                    <li class="nav-item"> <a class="nav-link" href="../../SesionActive/eService/service-grid.jsp"><i class="bi bi-bucket-fill"></i>Servicios</a></li>
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
                                                    <a class="h6 mt-2 mt-sm-0" href="#"><%= nom%></a>
                                                    <p class="small m-0"><%= email%></p>
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

                        <section class="pt-0">
                            <div class="container">
                                <div class="rounded-3 p-3 p-sm-5" style="background-image: url(../../../assets/images/bg/05.jpg); background-position: center center; background-repeat: no-repeat; background-size: cover;">
                                    <div class="row my-2 my-xl-5"> 
                                        <div class="col-md-8 mx-auto"> 
                                            <h1 class="text-center text-white">Servicios en Miguel Hidalgo</h1>
                                        </div>
                                    </div>

                                    
                                </div>
                            </div>
                        </section>
                        <section class="pt-0 pb-4">
                            <div class="container position-relative">

                                <div class="row">
                                    <div class="col-12">
                                        <div class="d-flex justify-content-between">
                                            <input type="checkbox" class="btn-check" id="btn-check-soft">
                                            
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </section>

                        <section class="pt-0">
                            <div class="container">
                                <div class="row g-4">
<%
    
    for (int i = 0; i < services.size(); i++) {
           String nombre = services.get(i).getNombreS();
           String categoria = services.get(i).getCategoria();
           String precio = services.get(i).getPrecio();
        

%>
                                    <div class="col-md-6 col-xl-4">
                                        <div class="card shadow p-2 pb-0 h-100">

                                            <div class="tiny-slider arrow-round arrow-xs arrow-dark rounded-2 overflow-hidden">
                                                <div class="tiny-slider-inner" data-autoplay="false" data-arrow="true" data-dots="false" data-items="1">
                                                    <div><img src="../../../assets/images/category/hotel/4by3/09.jpg" alt="Card image"></div>

                                                </div>
                                            </div>

                                            <div class="card-body px-3 pb-0">
             

 
                                            <h5 class="card-title"><a ><%= nombre %></a></h5>




                                                
                                                
                                                <ul class="nav nav-divider mb-2 mb-sm-3">
                                                    <li class="nav-item"><%= categoria%></li>
                                                    
                                                </ul>
                                            </div>
                                            <div class="card-footer pt-0">
                                                <div class="d-sm-flex justify-content-sm-between align-items-center">
                                                    <div class="d-flex align-items-center">
                                                        <h5 class="fw-normal text-success mb-0 me-1">$ <%= precio%></h5>
                
                                                        
                                                    </div>
                                                    <div class="mt-2 mt-sm-0">
                                                        <form method="GET" ">
                                                                <button  type="submit" id="pago" name="pago" value="<%= i%>" class="btn btn-outline-success">Contratar</button>
                                                        </form>
                                                    </div>
                                                        
                                                        
                                                        
                                                        
                                                </div>
                                            </div>
                                        </div>
                                    </div>
<%
    }

                
                String info =request.getParameter("detail"); 
                String pago =request.getParameter("pago"); 

                if (info != null){

                Servicio serviceN = services.get(Integer.parseInt(info));
                session.setAttribute("servicio", serviceN);

 %>
 
    <script>
        window.location.href = 'service-detail.jsp';
    </script>



<%
}
                if (pago != null){

                Servicio serviceN = services.get(Integer.parseInt(pago));
                session.setAttribute("servicio", serviceN);



                System.out.println(serviceN.getNombreS());
 %>
 
    <script>
        window.location.href = 'service-booking.jsp';
    </script>



<% 
    } 
%>
                                    
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
                                    <li class="nav-item"><a class="nav-link text-muted" href="../../SesionActive/eService/service-grid.jsp"><i class="bi bi-bucket-fill me-2"></i>Servicios</a>
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

                    <script src="../../../assets/vendor/flatpickr/js/flatpickr.min.js"></script>
                    <script src="../../../assets/vendor/choices/js/choices.min.js"></script>
                    <script src="../../../assets/vendor/tiny-slider/tiny-slider.js"></script>
                    <script src="../../../assets/vendor/nouislider/nouislider.min.js"></script>

                    <script src="../../../assets/js/functions.js"></script>

                    </body>
                    </html>