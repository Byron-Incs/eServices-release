<%@page import="org.eServices.dao.Usuario"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>




<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services - Registro</title>

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

        <link rel="shortcut icon" href="../assets/images/favicon.ico">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&family=Poppins:wght@400;500;700&display=swap">

        <link rel="stylesheet" type="text/css" href="../../assets/vendor/font-awesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="../../assets/vendor/bootstrap-icons/bootstrap-icons.css">

        <link rel="stylesheet" type="text/css" href="../../assets/css/style.css">

    </head>

    <body>
        <%
            String accion = request.getParameter("accion");
            String check = request.getParameter("check");
            
            

            String url = "jdbc:mysql://localhost:3306/eservices";
            String usuario = "root";
            String contrasena = "1234";
            
            
            //se extraen los datos de la url y se guardan en variables
            String email = request.getParameter("email");
            String nombre = request.getParameter("nombre");
            String app= request.getParameter("apellido_p");
            String apm= request.getParameter("apellido_m");
            String curp= request.getParameter("curp");
            String contra= request.getParameter("ps");
            
            
            Usuario user = new Usuario();
            user.setApellido_m(apm);
            user.setApellido_p(app);
            user.setContrasena(contra);
            user.setCurp(curp);
            user.setEmail(email);
            user.setNombre_usuario(nombre);
            
            if("Guardar".equals( accion )){
            
            if(email.isEmpty() && nombre.isEmpty() && app.isEmpty() && apm.isEmpty() && curp.isEmpty() && contra.isEmpty()){
            
            %>
            <script>
            
            alert("¡Llena todos los campos!");
            
            </script>
            
            
<%
            }else {
            
            

            //caso uno: eligio cuenta de vendedor
            if ("Guardar".equals( accion ) && "1".equals( check )){
            
            
            
       

        Connection conexion = null;
        Statement sentencia = null;
        
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        
          //se inicia la conexion
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection(url, usuario, contrasena);
            sentencia = conexion.createStatement();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
 
   
                
                                
                //se insertan los datos a un registros en usuario
                String consulta = "INSERT INTO Usuario (email, nombre, apellido_p, apellido_m, curp, contrasena) VALUES ('" + email + "', '" + nombre + "', '" + app + "', '" + apm + "', '" + curp + "', '" + contra + "')";

                try {
                sentencia.executeUpdate(consulta);
                
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            
            //se extrae el id_usuario del la bd apartir del curp
            String selectQuery = "SELECT id_usuario FROM Usuario WHERE curp = ?";
            statement = conexion.prepareStatement(selectQuery);
            statement.setString(1, curp);
            resultSet = statement.executeQuery();

            int id = 0;
            
            
            //se guarda en una variable el id_usuario
            if (resultSet.next()) {
                id = resultSet.getInt("id_usuario");
            }
           
            
            //se genera un registro en roles_usuario con la id_usuario y id de vendedor
            String consulta1 = "INSERT INTO roles_usuario (id_usuario, id_rol) VALUES ('" + id + "', '" + "1" + "')";

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
            } catch (SQLException e) {
                 e.printStackTrace();
            }
            
            
            HttpSession sesion = request.getSession();
            session.setAttribute("user", user);



%>
 
    <script>
        
        window.location.href = '../SesionActive/Cuenta/Vendedor/admin-agent-edit.jsp';
        
    </script>



<%
            }
            
            
            else if("Guardar".equals( accion )){
            


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
 
   
                System.out.println(email);
                System.out.println(curp);
                System.out.println(nombre);
                System.out.println(app);
                System.out.println(apm);
                System.out.println(contra);
                                

                String consulta = "INSERT INTO Usuario (email, nombre, apellido_p, apellido_m, curp, contrasena) VALUES ('" + email + "', '" + nombre + "', '" + app + "', '" + apm + "', '" + curp + "', '" + contra + "')";

                try {
                sentencia.executeUpdate(consulta);
                
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            
            String selectQuery = "SELECT id_usuario FROM Usuario WHERE curp = ?";
            statement = conexion.prepareStatement(selectQuery);
            statement.setString(1, curp);
            resultSet = statement.executeQuery();

            int id = 0; // Inicializar la variable "id" antes de asignarle un valor

            if (resultSet.next()) {
                id = resultSet.getInt("id_usuario");
            }
           
            
            
            String consulta1 = "INSERT INTO roles_usuario (id_usuario, id_rol) VALUES ('" + id + "', '" + "2" + "')";

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
            } catch (SQLException e) {
                 e.printStackTrace();
            }
            
            
            HttpSession sesion = request.getSession();
            session.setAttribute("user", user);

            %>
 
    <script>
        
        window.location.href = '../SesionActive/home-page.jsp';
    </script>



<%
            
            
            }
            }
}
            
            

          


                %>
             
  
        <main>

            <section class="vh-xxl-100">
                <div class="container h-100 d-flex px-0 px-sm-4">
                    <div class="row justify-content-center align-items-center m-auto">
                        <div class="col-12">
                            <div class="bg-mode shadow rounded-3 overflow-hidden">
                                <div class="row g-0">
                                    <div class="col-lg-6 d-md-flex align-items-center order-2 order-lg-1">
                                        <div class="p-3 p-lg-5">
                                            <img src="../../assets/images/element/signin.svg" alt="">
                                        </div>
                                        <div class="vr opacity-1 d-none d-lg-block"></div>
                                    </div>

                                    <div class="col-lg-6 order-1">
                                        <div class="p-4 p-sm-6">
                                            <a href="../../index.html">
                                                <img class="h-50px mb-4" src="../../assets/images/logo-icon.svg" alt="logo">
                                            </a>




                                            <h1 class="mb-2 h3">Crear Cuenta</h1>
                                            <p class="mb-0">¿Ya tienes cuenta?<a href="sign-in.jsp"> Iniciar sesión</a></p>

                                            <form class="mt-4 text-start">
                                                <div class="mb-3">
                                                    <label class="form-label">Email</label>
                                                    <input type="email" class="form-control" name="email" id="email">
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label class="form-label">curp</label>
                                                    <input type="text" class="form-control" name="curp" id="curp">
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label class="form-label">Nombre(s)</label>
                                                    <input type="text" class="form-control" name="nombre" id="nombre">
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label">Apellido Paterno</label>
                                                    <input type="text" class="form-control" name="apellido_p" id="apellido_p">
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label class="form-label">Apellido Materno</label>
                                                    <input type="text" class="form-control" name="apellido_m" id="apellido_m">
                                                </div>
                                                
                                               <div class="mb-3">
                                                    <label class="form-label">Contraseña</label>
                                                    <input type="password" class="form-control" name="ps" id="ps">
                                                </div>
                                                  
                                                
                                




                                                
                                                
                                                <div class="mb-3">
                                                    <input type="checkbox" class="form-check-input" name = "check" id="check" value ="1" id="rememberCheck">
                                                    <label class="form-check-label" for="rememberCheck">Cuenta de colaborador?</label>
                                                </div>
                                                
                                                
                                                
                                                <div><button type="submit" class="btn btn-primary w-100 mb-0" name = "accion" id="accion" value ="Guardar">Crear cuenta </button></div>
                                                
                                                
                                               
                                                




                                            </form>
                                        </div>		
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </main>
        <div class="back-top"></div>

        <script src="../../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

        <script src="../../assets/js/functions.js"></script>

    </body>
</html>