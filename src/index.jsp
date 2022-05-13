<!DOCTYPE html>
<html>
	<head>
		<!-- Required meta tags -->
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

		<!-- Bootstrap CSS v5.0.2 -->
		<link rel="stylesheet" href="src/main/webapp/bootstrap/bootstrap.min.css" />

		<script src="src/main/webapp/bootstrap/bootstrap.bundle.min.js"></script>

		<link rel="stylesheet" href="src/main/webapp/style.css" />

		<title>Simple URL Shortener</title>
		<link rel="icon" href="src/main/webapp/img/logo.png" type="image/icon type" />
	</head>
	<body>
		<!-- Start Of Header -->
		<div class="container header">
			<div class="row align-items-center">
				<div class="col-md-3">
					<div class="media">
						<a href="" class="nav_thing"
							><img src="src/main/webapp/img/big-logo.png" class="nav-img mx-auto d-block"
						/></a>
					</div>
				</div>
				<div class="col-md-6 nav_thing text-center">
					<a href="" class="nav_thing-center">Why Us?</a>
					<a href="" class="nav_thing-center">Custom URL</a>
					<a href="" class="nav_thing-center">Pricing</a>
					<a href="" class="nav_thing-center">Contact Us</a>
				</div>
				<div class="col-md-3 text-center account-head-dv">
					<a href="login" class="account-head">Login</a> &nbsp; &nbsp; | &nbsp;&nbsp;
					<a href="register" class="account-head">Sign Up</a>
				</div>
			</div>
		</div>
		<!-- End Of Header -->
		<!-- Start Of Main Body -->
		<!-- Start of shortening section -->
		<div class="container">
			<div class="row align-items-center shorten-body">
				<div class="col-md-3"></div>
				<div class="col-md-6 text-center">
					<form action="/cgi-bin/shorten.cgi" method="post">
						<h2 class="main-title">Start Shortening</h2>
						<div class="input-group mb-3">
							<input
								name="url"
								class="form-control"
								type="text"
								id="main-box"
								placeholder="Your link goes here"
								required
							/>
							<div class="input-group-append">
								<button class="btn px-4" type="submit" id="main-btn">
									<i class="bi bi-box-arrow-right"></i>
								</button>
							</div>
						</div>
					</form>
				</div>
				<div class="col-md-3"></div>
			</div>
		</div>
		<!-- End of Shortening section -->
		<!-- Start Of Carousel -->
		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button
					type="button"
					data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="0"
					class="active"
					aria-current="true"
					aria-label="Slide 1"
				></button>
				<button
					type="button"
					data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="1"
					aria-label="Slide 2"
				></button>
			</div>

			<!-- The slideshow -->
			<div class="carousel-inner caro">
				<div class="carousel-item active">
					<div class="row align-items-center">
						<div class="col-md-6 text-center ct-cont">
							<h2 class="ct-head">All Your Links in one place!</h2>
							<p class="caro_text">
								Simply create an account and have easy access to all your links in one place so that
								you don't have to spend another minute searching for links!!!
							</p>
						</div>
						<div class="col-md-6">
							<img src="src/main/webapp/img/bitly.png" alt="Los Angeles" class="caro_img" />
						</div>
					</div>
				</div>

				<div class="carousel-item">
					<div class="row align-items-center">
						<div class="col-md-6 text-center ct-cont">
							<h2 class="ct-head">Exciting Prices</h2>
							<p class="caro_text">
								Cost efficient plans that are tailored to you needs and ensure you get the bang for
								your buck!!
							</p>
						</div>
						<div class="col-md-6">
							<img src="src/main/webapp/img/pricing.png" alt="Los Angeles" class="caro_img" />
						</div>
					</div>
				</div>
			</div>

			<!-- Left and right controls -->
			<button
				class="carousel-control-prev"
				type="button"
				data-bs-target="#carouselExampleIndicators"
				data-bs-slide="prev"
			>
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button
				class="carousel-control-next"
				type="button"
				data-bs-target="#carouselExampleIndicators"
				data-bs-slide="next"
			>
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		<!-- End of Carousel -->
		<!-- End Of Main Body -->
		<!-- Start of Footer -->
		<div class="container">
			<div class="row foot-row">
				<div class="col-md-4">
					<div class="foot-t">Information</div>

					<a href="#" class="foot-lk">About us</a><br />
					<a href="#" class="foot-lk">Billing Information</a><br />
					<a href="#" class="foot-lk">Privacy & Policy</a><br />
					<a href="#" class="foot-lk">Terms & Condition</a><br />
					<a href="#" class="foot-lk">Data Policies</a><br />
				</div>

				<div class="col-md-4">
					<div class="foot-t">Socials</div>

					<a href="#" class="foot-lk">Instagram&nbsp;&nbsp;&nbsp;<i class="bi bi-instagram"></i></a
					><br />
					<a href="#" class="foot-lk"
						>Twitter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="bi bi-twitter"></i></a
					><br />
					<a href="#" class="foot-lk"
						>Facebook&nbsp;&nbsp;&nbsp;&nbsp;<i class="bi bi-facebook"></i></a
					><br />
					<a href="#" class="foot-lk"
						>Discord&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="bi bi-discord"></i></a
					><br />
					<a href="#" class="foot-lk"
						>Reddit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i
							class="bi bi-reddit"
						></i></a
					><br />
				</div>

				<div class="col-md-4">
					<div class="foot-t">About Us</div>
					<div class="foot-lk">
						We are a modern link shortening company focused on developing solutions that are fast
						and efficient!
					</div>
					<div class="foot-lk">
						We are fiercely committed to our customers' success. Our job is to ensure that our
						trusted platform, performance, and people help customers achieve their goals.
					</div>
				</div>
			</div>
		</div>
		<!-- End of Footer -->
	</body>
</html>
