
		MultipartFile drugLicenceMF = memberAddDtlModel.getDrugLicenceMF();
	    System.out.println("IN Testing ACTION");
	    System.out.println("drugLicenceMF::" + drugLicenceMF);
	    System.out.println("ALL DATA -- "+memberAddDtlModel.toString());
		String res = "";
		List<String> errorMessage = new ArrayList<String>();
		if (result.hasErrors()) {
			List<ObjectError> errorList = result.getAllErrors();
			for (int i = 0; i < errorList.size(); i++) {
				String codes = errorList.get(i).getCodes()[1].substring(
						errorList.get(i).getCodes()[1].lastIndexOf(".") + 1, errorList.get(i).getCodes()[1].length());
				errorMessage.add(errorList.get(i).getDefaultMessage());
			}
			attr.addFlashAttribute("errors", errorMessage);
			res = "redirect:/AddAddressDetails";

		} else {
			InstPremiseDtlDomain instDomain = davaServices.addInstPreDetail(memberAddDtlModel, request);
			// (G-CODE) START
			int numInstId = instDomain.getNumInstid();
			System.out.println("numInstId: " + numInstId);

			String loogedInUserIdName = SecurityContextHolder.getContext().getAuthentication().getName();
			System.out.println("loogedInUserIdName: " + loogedInUserIdName);
			
			RegistrationDetails rg = userRepository.findByUserName(loogedInUserIdName);
			
			Long userId = rg.getUserId();
			System.out.println("Logged userID: " + userId);
			
			String loogedInUserId = Long.toString(userId);

			String applicantType = userRepository.findApplicantTypeByUserId(userId);
			System.out.println("Applicant Type: " + applicantType);

			String rootDirectory = ftpProps.getDirectory();
			System.out.println("Root Directory: " + rootDirectory);

			String finalPath = rootDirectory + "/" + applicantType + "/" + loogedInUserId + "/";
			System.out.println("Final Path: " + finalPath);

			String filename = drugLicenceMF.getOriginalFilename();
			System.out.println("Filename: " + filename);

			long doc_size_long = drugLicenceMF.getSize();
			int doc_size = (int) doc_size_long;
			System.out.println("Document Size: " + doc_size);

			    String drugDetailsPath = finalPath;
			    System.out.println("Drug Details Path: " + drugDetailsPath);

			    String uniqName = generateRandomAlphabets(3);
			    System.out.println("Unique Name: " + uniqName);

			    String drugsDetails = drugDetailsPath + loogedInUserId + "_manufsiteLic-" + uniqName + ".pdf";
			    System.out.println("Drugs Details: " + drugsDetails);

			    String directory = drugsDetails;
			    System.out.println("Directory: " + directory);

			    int doc_id = gService.addDocument(directory, doc_size, filename, "Manufacturing Unit Drug License Details", 1000001);
			    System.out.println("Document ID: " + doc_id);

			    instPremiseDtlRepository.updateNumDocumentId(numInstId, doc_id);
			    instPremiseDtlRepository.setZero(numInstId);

			    try {
			        ftpService.uploadFile(drugDetailsPath + loogedInUserId + "_manufsiteLic-" + uniqName + ".pdf",
			                drugLicenceMF.getInputStream(), drugDetailsPath);
			    } catch (IOException e) {
			        e.printStackTrace();
			    }

			// (G-CODE) END
