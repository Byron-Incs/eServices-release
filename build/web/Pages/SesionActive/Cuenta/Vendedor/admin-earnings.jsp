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
        <title>e-Services - Tarjetas</title>

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

                <section class="pt-3">
                            <div class="container">
                                <div class="row g-2 g-lg-4">

                                   
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

                                            <div class="card-body p-2 p-sm-4">

                                            
                                            
                                            
                                            
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
                        </section>

                    
            </div>

        </main>

        <script src="../../../../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

        <script src="../../../../assets/vendor/overlay-scrollbar/js/overlayscrollbars.min.js"></script>

        <script src="../../../../assets/js/functions.js"></script>

    </body>
</html>