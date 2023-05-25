<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services - Autentificación de dos pasos</title>

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

        <link rel="shortcut icon" href="../../assets/images/favicon.ico">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&family=Poppins:wght@400;500;700&display=swap">

        <link rel="stylesheet" type="text/css" href="../../assets/vendor/font-awesome/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="../../assets/vendor/bootstrap-icons/bootstrap-icons.css">

        <link rel="stylesheet" type="text/css" href="../../assets/css/style.css">

    </head>

    <body>

        <main>

            <section class="vh-xxl-100">
                <div class="container h-100 d-flex px-0 px-sm-4">
                    <div class="row justify-content-center align-items-center m-auto">
                        <div class="col-12">
                            <div class="shadow bg-mode rounded-3 overflow-hidden">
                                <div class="row g-0 align-items-center">
                                    <div class="col-lg-6 d-md-flex align-items-center order-2 order-lg-1">
                                        <div class="p-3 p-lg-5">
                                            <img src="../../assets/images/element/forgot-pass.svg" alt="">
                                        </div>
                                        <div class="vr opacity-1 d-none d-lg-block"></div>
                                    </div>

                                    <div class="col-lg-6 order-1">
                                        <div class="p-4 p-sm-7">
                                            <a href="../../index.html">
                                                <img class="mb-4 h-50px" src="../../assets/images/logo-icon.svg" alt="logo">
                                            </a>
                                            <h1 class="mb-2 h3">Autenticación en dos pasos</h1>
                                            <p class="mb-sm-0">Enviamos un código a <b>ejemplo@gmail.com</b></p>

                                            <form class="mt-sm-4">
                                                <p class="mb-1">Introduce el código que hemos enviado:</p>
                                                <div class="autotab d-flex justify-content-between gap-1 gap-sm-3 mb-2">
                                                    <input type="text" maxlength="1" class="form-control text-center p-3">
                                                    <input type="text" maxlength="1" class="form-control text-center p-3">
                                                    <input type="text" maxlength="1" class="form-control text-center p-3">
                                                    <input type="text" maxlength="1" class="form-control text-center p-3">
                                                </div>

                                                <div class="d-sm-flex justify-content-between small mb-4">
                                                    <span>¿No recibes el código?</span>
                                                    <a href="#" class="btn btn-sm btn-link p-0 text-decoration-underline mb-0">Click para reenviar</a>
                                                </div>

                                                <div><button type="submit" class="btn btn-primary w-100 mb-0">Verificar</button></div>

                                                <div class="text-primary-hover mt-3 text-center"> Copyrights ©2023 e-Services. Build by <a href="http://byroninc.gerdoc.com">Byron.inc</a>. </div>
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