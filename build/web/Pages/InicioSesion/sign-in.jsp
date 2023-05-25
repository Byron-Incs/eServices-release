<%@page import="org.eServices.dao.Usuario"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services - Incio de Sesión</title>

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
            String contra= request.getParameter("ps");
            
            
            Usuario user = new Usuario();
            user.setEmail(email);
            user.setContrasena(contra);
            
            if("Guardar".equals( accion )){
            
            if(email.isEmpty() && contra.isEmpty()){
            
            %>
            <script>
            
            alert("¡Llena todos los campos!");
            
            </script>
            
            
<%
    }else{

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
 




            String selectQuery = "SELECT contrasena FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

            String psw = null;
            
            
            if (resultSet.next()) {
                psw = resultSet.getString("contrasena");
            }


        String selectQuery1 = "SELECT id_usuario FROM Usuario WHERE email = ?";
            statement = conexion.prepareStatement(selectQuery1);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

            int id = 0;
            
            
            if (resultSet.next()) {
                id = resultSet.getInt("id_usuario");

            }




            if (contra.equals(psw)){



            String selectQuery2 = "SELECT id_rol FROM roles_usuario WHERE id_usuario = ?";
            statement = conexion.prepareStatement(selectQuery2);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();

            int idr = 0;
            
            
            if (resultSet.next()) {
                idr = resultSet.getInt("id_rol");

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

            
            
            if (idr==2){
            
            

            %>
 
    <script>
        window.location.href = '../SesionActive/home-page.jsp';
    </script>



<%
    }else{

 %>
 
    <script>
        window.location.href = '../SesionActive/Cuenta/Vendedor/admin-agent-edit.jsp';
    </script>



<%
}
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
                                    <div class="col-lg-6 d-flex align-items-center order-2 order-lg-1">
                                        <div class="p-3 p-lg-5">
                                            <img src="../../assets/images/element/signin.svg" alt="">
                                        </div>
                                        <div class="vr opacity-1 d-none d-lg-block"></div>
                                    </div>

                                    <div class="col-lg-6 order-1">
                                        <div class="p-4 p-sm-7">
                                            <a href="../../index.html">
                                                <img class="h-50px mb-4" src="../../assets/images/logo-icon.svg" alt="logo">
                                            </a>
                                            <h1 class="mb-2 h3">Bienvenido de nuevo</h1>
                                            <p class="mb-0">¿Aún no tienes cuenta?<a href="sign-up.jsp">  Resgístrate</a></p>

                                            <form class="mt-4 text-start">
                                                <div class="mb-3">
                                                    <label class="form-label">Email</label>
                                                    <input type="email" class="form-control" name="email" id="email">
                                                </div>
                                                
                                                
                                                
                                                
                                                <div class="mb-3">
                                                    <label class="form-label">Contraseña</label>
                                                    <input type="password" class="form-control" name="ps" id="ps">
                                                </div>
                 
                                                    <a href="forgot-password.jsp">¿Olvidaste tu contraseña?</a>

                                                </div>
                                                <div><button type="submit" class="btn btn-primary w-100 mb-0" name = "accion" id="accion" value ="Guardar">Iniciar sesión</button></div>






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