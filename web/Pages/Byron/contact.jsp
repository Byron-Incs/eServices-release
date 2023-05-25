
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services - Contáctanos</title>

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

	<header class="navbar-light header-sticky">
		<nav class="navbar navbar-expand-xl">
			<div class="container">
				<a class="navbar-brand" href="contact.jsp">
					<img class="light-mode-item navbar-brand-item" src="../../assets/images/logo.svg" alt="logo">
					<img class="dark-mode-item navbar-brand-item" src="../../assets/images/logo-light.svg" alt="logo">
				</a>
				
                                        <button class="navbar-toggler ms-sm-auto mx-3 me-md-0 p-0 p-sm-2" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCategoryCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-animation">
								<span></span>
								<span></span>
								<span></span>
							</span>
                                        </button>


						

						
						<div class="navbar-collapse collapse" id="navbarCategoryCollapse">
							<ul class="navbar-nav navbar-nav-scroll nav-pills-primary-soft text-center ms-auto p-2 p-xl-0">
									<li class="nav-item"> <a class="nav-link" href="about.html">Conócenos</a></li>
									<li class="nav-item"><a class="nav-link" href="team.html">Nuestro Equipo</a></li>
                                                                        <li class="nav-item"><a class="nav-link" href="privacy-policy.html">Políticas </a></li>
                                                        </ul>
						</div>
	</header>
                    <main>

                        <section class="pt-4 pt-md-5">
                            <div class="container">
                                <div class="row mb-5">
                                    <div class="col-xl-10">
                                        <h1>Contáctanos</h1>
                                        <p class="lead mb-0">Ponte en contacto con nosotros.</p>
                                    </div>
                                </div>

                                <div class="row g-4">

                                    <div class="col-md-6 col-xl-4">
                                        <div class="card card-body shadow text-center align-items-center h-100">
                                            <div class="icon-lg bg-info bg-opacity-10 text-info rounded-circle mb-2"><i class="bi bi-headset fs-5"></i></div>
                                            <h5>Llámanos</h5>
                                            <div class="d-grid gap-3 d-sm-block">
                                                <button class="btn btn-sm btn-light"><i class="bi bi-telephone me-2"></i>+52 55 5555 5555</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-xl-4">
                                        <div class="card card-body shadow text-center align-items-center h-100">
                                            <div class="icon-lg bg-danger bg-opacity-10 text-danger rounded-circle mb-2"><i class="bi bi-inboxes-fill fs-5"></i></div>
                                            <h5>Email</h5>
                                            <a href="#" class="btn btn-link text-decoration-underline p-0 mb-0"><i class="bi bi-envelope me-1"></i>byron.inc.jdb@gmail.com</a>
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </section>
                        <section class="pt-0 pt-lg-5">
                            <div class="container">
                                <div class="row g-4 g-lg-5 align-items-center">
                                    <div class="col-lg-6 text-center">
                                        <img src="../../assets/images/element/contact.svg" alt="">
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="card bg-light p-4">
                                            <figure class="position-absolute end-0 bottom-0 mb-n4 me-n2">
                                                <svg class="fill-orange" width="104.2px" height="95.2px">
                                                <circle cx="2.6" cy="92.6" r="2.6" />
                                                <circle cx="2.6" cy="77.6" r="2.6" />
                                                <circle cx="2.6" cy="62.6" r="2.6" />
                                                <circle cx="2.6" cy="47.6" r="2.6" />
                                                <circle cx="2.6" cy="32.6" r="2.6" />
                                                <circle cx="2.6" cy="17.6" r="2.6" />
                                                <circle cx="2.6" cy="2.6" r="2.6" />
                                                <circle cx="22.4" cy="92.6" r="2.6" />
                                                <circle cx="22.4" cy="77.6" r="2.6" />
                                                <circle cx="22.4" cy="62.6" r="2.6" />
                                                <circle cx="22.4" cy="47.6" r="2.6" />
                                                <circle cx="22.4" cy="32.6" r="2.6" />
                                                <circle cx="22.4" cy="17.6" r="2.6" />
                                                <circle cx="22.4" cy="2.6" r="2.6" />
                                                <circle cx="42.2" cy="92.6" r="2.6" />
                                                <circle cx="42.2" cy="77.6" r="2.6" />
                                                <circle cx="42.2" cy="62.6" r="2.6" />
                                                <circle cx="42.2" cy="47.6" r="2.6" />
                                                <circle cx="42.2" cy="32.6" r="2.6" />
                                                <circle cx="42.2" cy="17.6" r="2.6" />
                                                <circle cx="42.2" cy="2.6" r="2.6" />
                                                <circle cx="62" cy="92.6" r="2.6" />
                                                <circle cx="62" cy="77.6" r="2.6" />
                                                <circle cx="62" cy="62.6" r="2.6" />
                                                <circle cx="62" cy="47.6" r="2.6" />
                                                <circle cx="62" cy="32.6" r="2.6" />
                                                <circle cx="62" cy="17.6" r="2.6" />
                                                <circle cx="62" cy="2.6" r="2.6" />
                                                <circle cx="81.8" cy="92.6" r="2.6" />
                                                <circle cx="81.8" cy="77.6" r="2.6" />
                                                <circle cx="81.8" cy="62.6" r="2.6" />
                                                <circle cx="81.8" cy="47.6" r="2.6" />
                                                <circle cx="81.8" cy="32.6" r="2.6" />
                                                <circle cx="81.8" cy="17.6" r="2.6" />
                                                <circle cx="81.8" cy="2.6" r="2.6" />
                                                <circle cx="101.7" cy="92.6" r="2.6" />
                                                <circle cx="101.7" cy="77.6" r="2.6" />
                                                <circle cx="101.7" cy="62.6" r="2.6" />
                                                <circle cx="101.7" cy="47.6" r="2.6" />
                                                <circle cx="101.7" cy="32.6" r="2.6" />
                                                <circle cx="101.7" cy="17.6" r="2.6" />
                                                <circle cx="101.7" cy="2.6" r="2.6" />
                                                </svg>
                                            </figure>

                                            <div class="card-header bg-light p-0 pb-3">
                                                <h3 class="mb-0">Mándanos un mensaje</h3>
                                            </div>

                                            <div class="card-body p-0">
                                                <form class="row g-4">
                                                    <div class="col-md-6">
                                                        <label class="form-label">Nombre *</label>
                                                        <input type="text" class="form-control">
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Email  *</label>
                                                        <input type="email" class="form-control">
                                                    </div>
                                                    <div class="col-12">
                                                        <label class="form-label">Número de Teléfono *</label>
                                                        <input type="text" class="form-control">
                                                    </div>
                                                    <div class="col-12">
                                                        <label class="form-label">Mensaje *</label>
                                                        <textarea class="form-control" rows="3"></textarea>
                                                    </div>

                                                    <div class="col-12">
                                                        <button class="btn btn-dark mb-0" type="button">Enviar</button>
                                                    </div>
                                                </form>
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
					<a href="../../index.html">
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
								<li class="nav-item"><a class="nav-link text-muted" href="about.html">Acerca De Nosotros</a></li>
								<li class="nav-item"><a class="nav-link text-muted" href="contact.jsp">Contáctanos</a></li>
							</ul>
						</div>

						<div class="col-6 col-md-5">
							<h5 class="text-white mb-2 mb-md-4">Links</h5>
							<ul class="nav flex-column text-primary-hover">
								<li class="nav-item"><a class="nav-link text-muted" href="../InicioSesion/sign-up.jsp">Regístrate</a></li>
								<li class="nav-item"><a class="nav-link text-muted" href="../InicioSesion/sign-in.jsp">Ingresa</a></li>
								<li class="nav-item"><a class="nav-link text-muted" href="privacy-policy.html">Políticas De Privacidad</a></li>
							</ul>
						</div>

						<div class="col-6 col-md-3">
							<h5 class="text-white mb-2 mb-md-4">Servicios</h5>
							<ul class="nav flex-column text-primary-hover">
								<li class="nav-item"><a class="nav-link text-muted" href="../InicioSesion/sign-in.jsp"><i class="bi bi-bucket-fill me-2"></i>Servicios</a>
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
								<li class="list-inline-item me-0"><a class="nav-link py-1 text-muted" href="privacy-policy.html">Privacy policy</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
                        <div class="back-top"></div>

                        <script src="../../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

                        <script src="../../assets/js/functions.js"></script>

    </body>
</html>
