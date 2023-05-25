<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>e-Services - Puntuación de Trabajador</title>

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
        <link rel="stylesheet" type="text/css" href="../../../../assets/vendor/choices/css/choices.min.css">

        <link rel="stylesheet" type="text/css" href="../../../../assets/css/style.css">

    </head>

    <body>

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
                            <li class="nav-item"> <a class="nav-link" href="admin-earnings.jsp">Ganancias</a></li>
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

                <div class="page-content-wrapper p-xxl-4">

                    <div class="row">
                        <div class="col-12 mb-4 mb-sm-5">
                            <h1 class="h3 mb-0">Reseñas</h1>
                        </div>
                    </div>

                    <div class="row g-4 g-xl-5 mb-5">
                        <div class="col-md-6 col-lg-4">
                            <div class="bg-light p-4 rounded text-center">
                                <h6 class="fw-normal">Cantidad De Reseñas</h6>
                                <div class="d-flex align-items-center justify-content-center">
                                    <h2 class="mb-0 me-2">13.11K</h2>
                                    <div class="badge bg-success bg-opacity-10 text-success">21% <i class="bi bi-graph-up"></i></div>
                                </div>
                                <p class="mb-0">Reseñas Durante El Año</p>
                            </div>	
                        </div>

                        <div class="col-md-6 col-lg-4">
                            <div class="bg-light p-4 rounded text-center">
                                <h6 class="fw-normal">Calificación</h6>
                                <div class="d-flex align-items-center justify-content-center">
                                    <h2 class="mb-0 me-2">4.0</h2>
                                    <ul class="list-inline mb-0">
                                        <li class="list-inline-item me-0"><i class="fa-solid fa-star text-warning"></i></li>
                                        <li class="list-inline-item me-0"><i class="fa-solid fa-star text-warning"></i></li>
                                        <li class="list-inline-item me-0"><i class="fa-solid fa-star text-warning"></i></li>
                                        <li class="list-inline-item me-0"><i class="fa-solid fa-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="fa-solid fa-star text-secondary"></i></li>
                                    </ul>
                                </div>
                                <p class="mb-0">Calificación durante este año</p>
                            </div>	
                        </div>

                        <div class="col-lg-4">
                            <div class="bg-light p-4 rounded">
                                <div class="row gx-3 g-0 align-items-center">
                                    <div class="col-9 col-sm-10">
                                        <div class="progress progress-xs bg-warning bg-opacity-15">
                                            <div class="progress-bar bg-warning" role="progressbar" style="width: 95%" aria-valuenow="95" aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-3 col-sm-2 text-end">
                                        <small class="h6 fw-light mb-0">85%</small>
                                    </div>

                                    <div class="col-9 col-sm-10">
                                        <div class="progress progress-xs bg-warning bg-opacity-15">
                                            <div class="progress-bar bg-warning" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-3 col-sm-2 text-end">
                                        <small class="h6 fw-light mb-0">75%</small>
                                    </div>

                                    <div class="col-9 col-sm-10">
                                        <div class="progress progress-xs bg-warning bg-opacity-15">
                                            <div class="progress-bar bg-warning" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-3 col-sm-2 text-end">
                                        <small class="h6 fw-light mb-0">60%</small>
                                    </div>

                                    <div class="col-9 col-sm-10">
                                        <div class="progress progress-xs bg-warning bg-opacity-15">
                                            <div class="progress-bar bg-warning" role="progressbar" style="width: 35%" aria-valuenow="35" aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-3 col-sm-2 text-end">
                                        <small class="h6 fw-light mb-0">35%</small>
                                    </div>

                                    <div class="col-9 col-sm-10">
                                        <div class="progress progress-xs bg-warning bg-opacity-15">
                                            <div class="progress-bar bg-warning" role="progressbar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-3 col-sm-2 text-end">
                                        <small class="h6 fw-light mb-0">15%</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 justify-content-between align-items-center">

                        <div class="col-md-6 col-lg-3">
                            <form>
                                <select class="form-select js-choice" aria-label=".form-select-sm">
                                    <option value="">Ordenar Por</option>
                                    <option>Calificación</option>
                                    <option>Número De Reseñas</option>
                                </select>
                            </form>
                        </div>	
                    </div>

                    <div class="vstack gap-4 mt-5">
                        <div class="row g-3 g-lg-4">
                            <div class="col-md-4 col-xxl-3">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-xl me-2 flex-shrink-0">
                                        <img class="avatar-img rounded-circle" src="../../../../assets/images/avatar/02.jpg" alt="avatar">
                                    </div>
                                    <div class="ms-2">
                                        <h5 class="mb-1">Jacqueline Miller</h5>
                                        <p class="mb-0">Desde 21 Dec 2022</p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-8 col-xxl-9">
                                <ul class="list-inline mb-2">
                                    <li class="list-inline-item me-0"><i class="fas fa-star text-warning"></i></li>
                                    <li class="list-inline-item me-0"><i class="fas fa-star text-warning"></i></li>
                                    <li class="list-inline-item me-0"><i class="fas fa-star text-warning"></i></li>
                                    <li class="list-inline-item me-0"><i class="fas fa-star text-warning"></i></li>
                                    <li class="list-inline-item me-0"><i class="far fa-star text-warning"></i></li>
                                </ul>
                                <h6><span class="text-body fw-light">Reseña Por:</span> Usuario</h6>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ut vestibulum nisl. Cras sed turpis ut justo ullamcorper auctor. Duis nunc magna, pharetra vel egestas gravida, vulputate at nisl. In auctor lacus cursus luctus blandit. Mauris aliquam nulla nunc, sed interdum dui iaculis eu. Fusce nec interdum metus. Quisque lorem tellus, pharetra ut mi eu, consequat porttitor leo. Sed gravida, lorem in maximus commodo, leo nibh blandit leo, vitae commodo enim turpis ut est. Duis dignissim massa et blandit molestie.</p>

                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <a href="#" class="btn btn-sm btn-primary-soft mb-0">Contactar</a>
                                    </div>	
                                </div>
                                <div class="collapse show" id="collapseComment">
                                    <div class="d-flex mt-3">
                                        <textarea class="form-control mb-0" placeholder="Añadir Comentario..." rows="2" spellcheck="false"></textarea>
                                        <button class="btn btn-sm btn-primary ms-2 px-4 mb-0 flex-shrink-0"><i class="fas fa-paper-plane fs-5"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <hr class="m-0">

                        <div class="vstack gap-4 mt-5">
                            <div class="row g-3 g-lg-4">
                                <div class="col-md-4 col-xxl-3">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar avatar-xl me-2 flex-shrink-0">
                                            <img class="avatar-img rounded-circle" src="../../../../assets/images/avatar/03.jpg" alt="avatar">
                                        </div>
                                        <div class="ms-2">
                                            <h5 class="mb-1">Jacqueline Miller</h5>
                                            <p class="mb-0">Desde 21 Dec 2022</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-8 col-xxl-9">
                                    <ul class="list-inline mb-2">
                                        <li class="list-inline-item me-0"><i class="fas fa-star text-warning"></i></li>
                                        <li class="list-inline-item me-0"><i class="fas fa-star text-warning"></i></li>
                                        <li class="list-inline-item me-0"><i class="fas fa-star text-warning"></i></li>
                                        <li class="list-inline-item me-0"><i class="fas fa-star text-warning"></i></li>
                                        <li class="list-inline-item me-0"><i class="far fa-star text-warning"></i></li>
                                    </ul>
                                    <h6><span class="text-body fw-light">Reseña Por:</span> Usuario</h6>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ut vestibulum nisl. Cras sed turpis ut justo ullamcorper auctor. Duis nunc magna, pharetra vel egestas gravida, vulputate at nisl. In auctor lacus cursus luctus blandit. Mauris aliquam nulla nunc, sed interdum dui iaculis eu. Fusce nec interdum metus. Quisque lorem tellus, pharetra ut mi eu, consequat porttitor leo. Sed gravida, lorem in maximus commodo, leo nibh blandit leo, vitae commodo enim turpis ut est. Duis dignissim massa et blandit molestie.</p>

                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <a href="#" class="btn btn-sm btn-primary-soft mb-0">Contactar</a>
                                        </div>	
                                    </div>
                                    <div class="collapse show" id="collapseComment">
                                        <div class="d-flex mt-3">
                                            <textarea class="form-control mb-0" placeholder="Añadir Comentario..." rows="2" spellcheck="false"></textarea>
                                            <button class="btn btn-sm btn-primary ms-2 px-4 mb-0 flex-shrink-0"><i class="fas fa-paper-plane fs-5"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="d-sm-flex justify-content-sm-between align-items-sm-center">
                                <p class="mb-sm-0 text-center text-sm-start">Mostrando 1 a 7 de 21 entradas</p>
                                <nav class="mb-sm-0 d-flex justify-content-center" aria-label="navigation">
                                    <ul class="pagination pagination-sm pagination-primary-soft mb-0">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" tabindex="-1">Ant</a>
                                        </li>
                                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item active"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item disabled"><a class="page-link" href="#">..</a></li>
                                        <li class="page-item"><a class="page-link" href="#">17</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="#">Siguiente</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>	

                    </div>
                </div>

        </main>
        <script src="../../../../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

        <script src="../../../../assets/vendor/overlay-scrollbar/js/overlayscrollbars.min.js"></script>
        <script src="../../../../assets/vendor/choices/js/choices.min.js"></script>

        <script src="../../../../assets/js/functions.js"></script>

    </body>
</html>