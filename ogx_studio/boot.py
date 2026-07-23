def boot_session(bootinfo):
	"""Ensure desk boot uses Ogx Studio branding on every session."""
	bootinfo.app_logo_url = "/assets/ogx_studio/images/logo.png"
	bootinfo.app_name = "Ogx Studio"
