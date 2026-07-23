app_name = "ogx_studio"
app_title = "Ogx Studio"
app_publisher = "Ogx Studio"
app_description = "Ogx Studio branding and customizations for ERPNext"
app_email = "hello@ogxstudio.in"
app_license = "mit"
app_logo_url = "/assets/ogx_studio/images/logo.png"

required_apps = ["erpnext"]

add_to_apps_screen = [
	{
		"name": "ogx_studio",
		"logo": "/assets/ogx_studio/images/logo.png",
		"title": "Ogx Studio",
		"route": "/app",
	}
]

website_context = {
	"favicon": "/assets/ogx_studio/images/favicon.png",
	"splash_image": "/assets/ogx_studio/images/splash.png",
}

# Desk / website brand
brand_html = '<img src="/assets/ogx_studio/images/logo.png" style="max-width: 120px;">'

email_brand_image = "assets/ogx_studio/images/logo.png"

after_install = "ogx_studio.install.after_install"
after_migrate = "ogx_studio.install.after_migrate"

boot_session = "ogx_studio.boot.boot_session"
