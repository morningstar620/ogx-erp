import frappe


LOGO = "/assets/ogx_studio/images/logo.png"
LOGO_WHITE = "/assets/ogx_studio/images/logo-white.png"
SPLASH = "/assets/ogx_studio/images/splash.png"
FAVICON = "/assets/ogx_studio/images/favicon.png"
APP_NAME = "Ogx Studio"


def after_install():
	_apply_branding()


def after_migrate():
	_apply_branding()


def _apply_branding():
	_update_website_settings()
	_update_navbar_settings()
	frappe.clear_cache()


def _update_website_settings():
	if not frappe.db.exists("DocType", "Website Settings"):
		return

	ws = frappe.get_single("Website Settings")
	ws.app_name = APP_NAME
	ws.banner_image = LOGO
	ws.splash_image = SPLASH
	ws.favicon = FAVICON

	# Brand HTML used in website navbar
	ws.brand_html = f'<img src="{LOGO}" alt="{APP_NAME}" style="max-height: 28px;">'

	# Hide default ERPNext signup noise on login where supported
	if hasattr(ws, "disable_signup"):
		ws.disable_signup = 1

	ws.flags.ignore_permissions = True
	ws.save()


def _update_navbar_settings():
	if not frappe.db.exists("DocType", "Navbar Settings"):
		return

	ns = frappe.get_single("Navbar Settings")
	# Newer Frappe versions use app_logo on Navbar Settings
	if hasattr(ns, "app_logo"):
		ns.app_logo = LOGO
	ns.flags.ignore_permissions = True
	ns.save()
