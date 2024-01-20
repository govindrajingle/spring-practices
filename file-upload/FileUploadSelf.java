	@PostMapping("/getdrugChecksum")
	public @ResponseBody String getdrugChecksum(@RequestParam("drugLicence") MultipartFile file) {
		String stChecksum = "";
		try {
			byte[] uploadBytes = file.getBytes();
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			byte[] digest = md5.digest(uploadBytes);
			String hashString = new BigInteger(1, digest).toString(16);
			stChecksum = hashString.trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stChecksum;
	}