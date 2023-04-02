<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org" xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity3">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"></script>
	<style>
        body {
            background-color: #f0f0f0;
        }      

        .btn {
            background-color: #912338;
            color: #f0f0f0;
            border: none;
        }

        .btn:hover,
        .btn:focus,
        .btn:active {
            background-color: #da3a16;
            color: #f0f0f0;
        }

        .navbar{
            color: #f0f0f0;
            background-color: #912338;
        }

        .navbar a,
        .nav-item a {
            color: #f0f0f0;
            font-weight: 500;
            font-size: 17px;
        }

        .nav-item a:hover {
            color: #e5a712 !important; 
            font-weight: bold;
        }

        [class*="container"] {
            max-width: 1170px !important;
        }

        .concordia-txt-grey {
            color: #f0f0f0;
        }
    </style>
    <title>ConcordiaEats - Home</title>
</head>

<body>
    <!-- NAV -->
    <nav class="navbar navbar-expand-md navbar-dark sticky-top">
        <div class="container-fluid">
            <div class="d-flex">
                <img th:src="@{/images/ConcordiaEats-Logo-BW.svg}" src="/images/ConcordiaEats-Logo-BW.svg" width="auto" height="40"/>
                <h4 class="my-auto">&nbsp;Welcome ${ username } </h4>
            </div>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" th:href="@{/}" href="#">Home</a>
                    <!-- TO-DO -->
                    <li class="nav-item">
                        <a class="nav-link" th:href="@{/uproduct}" href="/user/products">Categories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" th:href="@{/favorites}" href="favorites">Favorites</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" th:href="@{/cart}" href="cart">Cart</a>
                    </li>
                    <!-- TO-DO/ -->
                    <li class="nav-item">
                        <a class="nav-link" href="profileDisplay">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" sec:authorize="isAuthenticated()" href="logout">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- NAV -->

    <section>   
        <div>
            <!-- CAROUSEL -->
            <div class="bg-product">
                <div class="container product">
                    <div class="row">
                        <div id="sliderproduct" class="carousel slide " data-ride="carousel" data-interval="10000">
                            <ol class="carousel-indicators">
                                <li data-target="#sliderproduct" data-slide-to="0" class="active"></li>
                                <li data-target="#sliderproduct" data-slide-to="1"></li>
                                <li data-target="#sliderproduct" data-slide-to="2"></li>
                            </ol>
                            
                            <div class="carousel-inner" role="listbox" data-interval="10000000">
                                <div class="carousel-item active">
                                    <div class="container text-center">
                                        <div class="row">
                                            <div class="col-sm-6 image">
                                                <div class="item">
                                                    <h1>Today's Deal</h1>
                                                    <img class="img-fluid" src="https://placehold.co/600x400/000000/FFFFFF.png" alt="">
                                                </div>
                                                <!--enditem-->
                                            </div>
                                            <!--endcol-->
                                            <div class="col-sm-6">
                                                <!--endtop-->
                                                <div class="details">
                                                    <h2 class="cr3">Burger</h2>
                                                    <p class="cr4"> tomato, green salad, pita,<br> ketchup, mayonnaise.</p>
                                                    <div class="rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <!--endrating-->
                                                    <p class="cr1">$ 3.55-$ 5.55 </p>
                                                    <a href="/user/products" class="btn btn-food">Buy Now</a>
                                                </div>
                                                <!--enddetails-->
                                            </div>
                                            <!--endcol-->
                                        </div>
                                        <!--endrow-->
                                    </div>
                                    <!--endcontainer-->
                                </div>
                                <!--endcarousel-item-->
                                <div class="carousel-item">
                                    <div class="container text-center">
                                        <div class="row">
                                            <div class="col-sm-6 image">
                                                <div class="item">
                                                    <h1>Today's Deal</h1>
                                                    <img class="img-fluid" src="https://placehold.co/600x400/000000/FFFFFF.png" alt="">
                                                </div>
                                                <!--enditem-->
                                            </div>
                                            <!--endcol-->
                                            <div class="col-sm-6">
                                                <!--endtop-->
                                                <div class="details">
                                                    <h2 class="cr3">cheeze pizza</h2>
                                                    <p class="cr4">margarita,<br> ketchup, maionese.</p>
                                                    <div class="rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <!--endrating-->
                                                    <p class="cr1">$ 3.55-$ 5.55</p>
                                                    <a href="/user/products" class="btn btn-food">Buy Now</a>
                                                </div>
                                                <!--enddetails-->
                                            </div>
                                            <!--endcol-->
                                        </div>
                                        <!--endrow-->
                                    </div>
                                    <!--endcontainer-->
                                </div>
                                <!--endcarousel-item-->
                                <div class="carousel-item">
                                    <div class="container text-center">
                                        <div class="row">
                                            <div class="col-sm-6 image">
                                                <div class="item">
                                                    <h1></h1>
                                                    <img class="img-fluid" src="https://placehold.co/600x400/000000/FFFFFF.png" alt="">
                                                </div>
                                                <!--enditem-->
                                            </div>
                                            <!--endcol-->
                                            <div class="col-sm-6">
                                                <!--endtop-->
                                                <div class="details">
                                                    <h2 class="cr3">fruits</h2>
                                                    <p class="cr4">margarita,<br> ketchup, maionese.</p>
                                                    <div class="rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <!--endrating-->
                                                    <p class="cr1">$ 3.55-$ 5.55</p>
                                                    <a href="/user/products" class="btn btn-food">Buy Now</a>
                                                </div>
                                                <!--enddetails-->
                                            </div>
                                            <!--endcol-->
                                        </div>
                                        <!--endrow-->
                                    </div>
                                    <!--endcontainer-->
                                </div>
                                <!--endcarousel-item-->
                                <a class="carousel-control-prev" href="#sliderproduct" role="button" data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                </a>
                                <a class="carousel-control-next" href="#sliderproduct" role="button" data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                </a>
                            </div>
                            <!--endslidesliderproduct-->
                        </div>
                        <!--endrow-->
                    </div>
                    <!--endcontainer-->
                </div>
                <!--endbg-product-->
            </div>
            <!-- CAROUSEL -->
            <style>
                .bg-product {
                    /* SET Height cho nó rồi bảo sao ko lỗi? */
                    /*height: 446px;*/
                    background: #d1d7f5;
                    /* overflow: hidden; */
                }

                #sliderproduct {
                    width: 100%;
                }

                #sliderproduct .carousel-inner {
                    overflow: visible;
                }

                #sliderproduct .col-sm-6.image {
                    background: #fff;
                    box-shadow: 0px 4px 8px 0px #959595;
                    position: relative;
                    /* Thêm cái của nợ này vào bảo sao nó ko tràn bờ đê */
                    /*top: -44px;
                    padding: 100px;
                    padding-top: 40px;*/
                }

                .item {
                    padding: 20px 20px 40px 20px;
                }

                .col-sm-6.image .item img.img-fluid {
                    /* Ai mướn thêm cái vào làm phá bố cục css của người ta.. mún trang web đẹp thì phải lựa cái ảnh đẹp đẹp vào rồi set cái độ rộng cho nó vừa là được rồi */
                    /*min-width: 100%;*/
                    width: 315px;
                }

                .col-sm-6.image h1 {
                    margin-bottom: 20px;
                }

                #sliderproduct .top a {
                    text-decoration: none;
                    text-transform: uppercase;
                    font-size: 18px;
                    padding: 14px 22px;
                    background: #e0794f;
                    box-sizing: border-box !important;
                    text-align: center;
                    margin: 0px 2px;
                    display: block;
                    color: #fff;
                    width: 96px;
                }

                #sliderproduct .col-sm-4.mr-auto {
                    margin-top: 22px;
                }

                #sliderproduct p.cr1 {
                    font-size: 20px;
                    font-weight: 500;
                    margin-bottom: 30px;
                }

                #sliderproduct .col-sm-6:last-child {
                    /* Cần nâng cao thêm kiến thức về sử dụng padding */
                    padding-top: 27px;
                    padding-bottom: 27px;
                }

                #sliderproduct .details p.d-inline-block {
                    color: #e0794f;
                }

                #sliderproduct .details .fa {
                    color: #e0794f;
                    padding: 0px 3px;
                }

                #sliderproduct .rating {
                    margin: 23px 0px;
                }

                #sliderproduct .details .btn {
                    text-transform: uppercase;
                    font-weight: 400;
                    padding: 16px 22px;
                    background: #e0794f;
                    color: #fff;
                    border-radius: 81px;
                    font-size: 14px;
                    display: inline-block;
                }

                #sliderproduct .details h2 {
                    margin: 25px 0px 30px 0px;
                    font-size: 24px;
                    font-weight: 700;
                }

                #sliderproduct .details p.cr4 {
                    font-weight: 500;
                    font-size: 16px;
                    line-height: 19px;
                    margin-bottom: 0px;
                }

                #sliderproduct .carousel-item {
                    transition: 0.4s;
                }

                #sliderproduct a.carousel-control-prev,
                #sliderproduct a.carousel-control-next {
                    border-radius: 50%;
                    background-color: brown;
                    width: 46px;
                    height: 46px;
                    font-size: 30px;
                    text-align: center;
                    line-height: 40px;
                    opacity: 1;
                    top: 50%;
                    transform: translate(0, -50%);
                }

                .bg {
                    height: 570px;
                    overflow: hidden;
                }

                #sliderproduct ol.carousel-indicators {
                    display: none;
                }
            </style>

            <!-- BOTTOM -->              
            <div class="row m-3 justify-content-center">
                <div class="col-lg-3 col-md-4">
                    <div class="card">
                        <a class="card-img-top">
                            <img th:src="@{/images/User-Categories.avif}" src="/images/User-Categories.avif" height="300"/>
                        </a>
                        <div class="card-content">
                            <h4 class="card-title">Categories</h4>
                            <p>Checkout out our products.<br></p>
                        </div>
                        <div class="card-read-more">
                            <a href="/user/products" class="btn btn-link btn-block">Browse</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-4">
                    <div class="card">
                        <a class="card-img-top">
                            <img th:src="@{/images/User-Deal.webp}" src="/images/User-Deal.webp" height="300"/>
                        </a>
                        <div class="card-content">
                            <h4 class="card-title">Best Deals</h4>
                            <p>Checkout out our deals.<br></p>
                        </div>
                        <div class="card-read-more">
                            <a href="/user/products" class="btn btn-link btn-block">Browse</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-4">
                    <div class="card">
                        <a class="card-img-top">
                            <img th:src="@{/images/User-Support.jpg}" src="/images/User-Support.jpg" height="300"/>
                        </a>
                        <div class="card-content">
                            <h4 class="card-title">Contact us</h4>
                            <p>Need Help? Find Us.<br></p>
                        </div>
                        <div class="card-read-more">
                            <a href="/contact" class="btn btn-link btn-block">Contact</a>
                        </div>
                    </div>
                </div>

                <style>
                    @import url('https://fonts.googleapis.com/css2?family=Titillium+Web:wght@200;300&display=swap');
                    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200&display=swap');
                    @import url('https://fonts.googleapis.com/css2?family=Arimo&display=swap');
                    @import url('https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c:wght@300&display=swap');
                    @import url('https://fonts.googleapis.com/css2?family=Signika:wght@300&display=swap');

                    h1.heading {
                        color: #fff;
                        font-size: 1.15em;
                        font-weight: 900;
                        margin: 0 0 0.5em;
                        color: #505050;
                        text-shadow: 0px 4px 3px rgba(0, 0, 0, 0.4),
                        0px 8px 13px rgba(0, 0, 0, 0.1),
                        0px 18px 23px rgba(0, 0, 0, 0.1);
                    }

                    @media (min-width: 450px) {
                        h1.heading {
                            font-size: 3.55em;
                        }
                    }

                    @media (min-width: 760px) {
                        h1.heading {
                            font-size: 3.05em;
                        }
                    }

                    @media (min-width: 900px) {
                        h1.heading {
                            font-size: 3.25em;
                            margin: 0 0 0.3em;
                        }
                    }
                    
                    .card {
                        display: block;
                        width: auto;
                        margin: 20px;
                        line-height: 1.42857143;
                        background-color: #fff;
                        border-radius: 2px;
                        min-width: 15rem;
                        min-height: 400px;
                        overflow: hidden;
                        transition: 0.5s ease;
                        animation: start_animation 0.5s ease 1;
                        box-shadow: rgba(0, 0, 0, 0.09) 0px 2px 1px, rgba(0, 0, 0, 0.09) 0px 4px 2px, rgba(0, 0, 0, 0.09) 0px 8px 4px, rgba(0, 0, 0, 0.09) 0px 16px 8px, rgba(0, 0, 0, 0.09) 0px 32px 16px;
                    }

                    .card:hover {
                        box-shadow: rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px;
                    }

                    .img-card {
                        width: 80%;
                        height: 225px;
                        min-width: 14rem;
                        border-top-left-radius: 2px;
                        border-top-right-radius: 2px;
                        display: flex;
                        overflow: hidden;
                    }

                    .img-card img {
                        margin-top: 15px;
                        width: fit-content;
                        height: 200px;
                        object-fit: cover;
                        transition: all .25s ease;
                        filter: drop-shadow(0.3rem 0.3rem 0.3rem rgba(0, 0, 0, 0.5));
                    }

                    .card-content {
                        padding: 15px;
                        text-align: left;
                    }

                    .card-title a {
                        color: #000;
                        text-decoration: none !important;
                    }

                    .card-read-more {
                        border-top: 1px solid #D4D4D4;
                    }

                    .card-read-more a {
                        text-decoration: none !important;
                        padding: 10px;
                        font-weight: 600;
                        text-transform: uppercase
                    }
                </style>
            </div>
        </div>
    </section>

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>