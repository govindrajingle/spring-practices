<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page import="in.cdacnoida.dava.util.DataEncoder"%>
<!DOCTYPE html>

<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Manufacturing Site Details</title>

<!-- <link rel="stylesheet" href="css/dataTable/datatables.bundle.css" rel="stylesheet">
<script type="text/javascript" src="css/dataTable/datatables.bundle.js"></script> -->
<!-- <script type="text/javascript" src="jquery-3.3.1.js"></script> -->
<!-- <link rel="stylesheet" href="css/datepicker/datepicker3.css" rel="stylesheet">
<script type="text/javascript" src="js/dataTable/bootstrap-datepicker.js"></script> -->

<!-- <script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/DwrServiceImpl.js"></script> -->

	<script type="text/javascript" src="js/formFieldValidation/CSRF2.js"></script>
	<script type="text/javascript" src="js/formFieldValidation/md5.js"></script>


<script type="text/javascript">
var addList = [];
var count = 0;
var editIndex;

function checkLicDate(){
	//alert("in check date");
	//alert($('#fromDate').val()+"     "+$('#toDate').val());
	if ($('#fromDate').val() != '' && $("#toDate").val() != '') {

		var mDate = $('#fromDate').val();
		var eDate = $('#toDate').val();
		var curDate = new Date();
		/* alert(curDate);
		
		if (curDate > eDate) {
			warning_message("Valid Upto cannot be smaller than current date");
			$('#toDate').val("");
		}else{
		} */

		if (eDate < mDate) {
			warning_message("Valid Upto cannot be smaller than Valid From!.");
			$('#fromDate').val("");
		} else {
		}
	}
}

function addtest(licenseTypeText, licenseType, licenseNumber, issueAuthId, FromDate, ToDate) {
	this.licenseTypeText = licenseTypeText;
	this.licenseType = licenseType;
	this.licenseNumber = licenseNumber;
	this.issueAuthId = issueAuthId;
	this.FromDate = FromDate;
	this.ToDate = ToDate;
}

function searchArray(nameKey, strLicType, strIssAuth, numFromDate, numToDate, myArray) {
	for (var i = 0; i < myArray.length; i++) {
		if (myArray[i].licenseNumber == nameKey
				&& myArray[i].licenseTypeText == strLicType
				&& myArray[i].issueAuthId == strIssAuth
				&& myArray[i].FromDate == numFromDate
				&& myArray[i].ToDate == numToDate) {
			return true;
		}
	}
}

function indexArray(nameKey, myArray) {
	for (var i = 0; i < myArray.length; i++) {
		if (myArray[i].licenseNumber == nameKey) {
			return i;
		}
	}
}

function clearFields() {
	$('#licType').val(0);
	$("#licNo").val("");
	$('#issueAuth').val("");
	$('#fromDate').val("");
	$('#toDate').val("");
}

function resetBootstrapFieldsLicDtls() {
	$('#frm').bootstrapValidator('resetField', 'licType')
			.bootstrapValidator('resetField', 'licNo')
			.bootstrapValidator('resetField', 'issueAuth')
			.bootstrapValidator('resetField', 'fromDate')
			.bootstrapValidator('resetField', 'toDate');
}

function enableBootstrapFieldsLicDtls(flag) {
	if (flag == true)
		$('#frm').bootstrapValidator('enableFieldValidators','licType', true)
				.bootstrapValidator('enableFieldValidators', 'licNo', true)
				.bootstrapValidator('enableFieldValidators','issueAuth', true)
				.bootstrapValidator('enableFieldValidators', 'fromDate', true)
				.bootstrapValidator('enableFieldValidators', 'toDate',true);
	else
		$('#frm').bootstrapValidator('enableFieldValidators','licType', false)
				.bootstrapValidator('enableFieldValidators', 'licNo', false)
				.bootstrapValidator('enableFieldValidators','issueAuth', false)
				.bootstrapValidator('enableFieldValidators', 'fromDate', false)
				.bootstrapValidator('enableFieldValidators', 'toDate',false);

}
function revalidateBootstrapFieldLicDtls() {
	$('#frm').bootstrapValidator('revalidateField','licType')
			.bootstrapValidator('revalidateField','licNo')
			.bootstrapValidator('revalidateField','issueAuth')
			.bootstrapValidator('revalidateField','fromDate')
			.bootstrapValidator('revalidateField', 'toDate');

}

//-----------------approval details add---------------------------------------------------------------------------------------

var addListforApp = [];
var countforApp = 0;
var editIndexforApp;

function checkAppDate(){
	//alert("in check date");
	//alert($('#appFromDate').val()+"     "+$('#appToDate').val());
	if ($('#appFromDate').val() != '' && $("#appToDate").val() != '') {
		
		var mDate = $('#appFromDate').val();
		var eDate = $('#appToDate').val();
		var curDate = new Date();
		/* alert(curDate);
		
		if (curDate > eDate) {
			warning_message("Valid Upto cannot be smaller than current date");
			$('#toDate').val("");
		}else{
		} */

		if (eDate < mDate) {
			warning_message("Valid Upto cannot be smaller than Valid From!.");
			$('#appFromDate').val("");
		} else {
		}
	}
}

function addtestforApproval(approvalTypeText, approvalType, approvalNumber, /* appIssueAuthId, */ approvalFromDate, approvalToDate) {
	this.approvalTypeText = approvalTypeText;
	this.approvalType = approvalType;
	this.approvalNumber = approvalNumber;
	//this.appIssueAuthId = appIssueAuthId;
	this.approvalFromDate = approvalFromDate;
	this.approvalToDate = approvalToDate;
}

function searchArrayforApproval(nameKey, strApprovalTypeText, /* strAppIssueAuthId, */ numApprovalFromDate, numApprovalToDate, myArray) {
	for (var i = 0; i < myArray.length; i++) {
		if (myArray[i].approvalNumber == nameKey
				&& myArray[i].approvalTypeText == strApprovalTypeText
				//&& myArray[i].appIssueAuthId == strAppIssueAuthId
				&& myArray[i].approvalFromDate == numApprovalFromDate
				&& myArray[i].approvalToDate == numApprovalToDate) {
			return true;
		}
	}
}

function indexArrayforApproval(nameKey, myArray) {
	for (var i = 0; i < myArray.length; i++) {
		if (myArray[i].approvalNumber == nameKey) {
			return i;
		}
	}
}

function clearFieldsforApproval() {
	$('#approvalType').val(0);
	$("#approvalNo").val("");
	//$('#appIssueAuth').val("");
	$('#appFromDate').val("");
	$('#appToDate').val("");
}

function resetBootstrapFieldsAppDtls() {
	$('#frm').bootstrapValidator('resetField', 'approvalType')
			.bootstrapValidator('resetField', 'approvalNo')
			//.bootstrapValidator('resetField', 'appIssueAuth')
			.bootstrapValidator('resetField', 'appFromDate')
			.bootstrapValidator('resetField', 'appToDate');
}


function checkdigit(input) {
	var barcode = input.substring( 0, input.length - 1 );
	//alert(barcode);
    let array = barcode.split('').reverse();

    let total = 0;
    let i = 1;
    array.forEach(number => {
        number = parseInt(number);
        if (i % 2 === 0) {
            total = total + number;
        }
        else
        {
            total = total + (number * 3);
        }
        i++;
    });
    var checsum=(Math.ceil(total / 10) * 10) - total;
    var finalno = barcode+"" + checsum;
    //alert (finalno);
   // alert (input);
    if (input ==finalno )    
    { 
        return (true); }
    else  
        {
    	$('#gln').val('');
		$('#frm').bootstrapValidator('revalidateField', 'gln');
		error_message("Please Enter Valid GLN Number");
    return (false);
        }
}

function checksum(g){
	//alert("GSTIN No : " + g);
	if (g.length == 15) {
    let a=65,b=55,c=36;
    if ( Array['from'](g).reduce((i,j,k,g)=>{ 
    p=(p=(j.charCodeAt(0)<a?parseInt(j):j.charCodeAt(0)-b)*(k%2+1))>c?1+(p-c):p;
    return k<14?i+p:j==((c=(c-(i%c)))<10?c:String.fromCharCode(c+b));
    },0))
        return true;
    else 
			{ //alert("False");
			$('#gstin').val('');
			$('#frm').bootstrapValidator('revalidateField', 'gstin');
			error_message("Please Enter Valid GSTIN Number");
	      return false;
	    }

	}
}

function enableBootstrapFieldsAppDtls(flag) {
	if (flag == true)
		$('#frm').bootstrapValidator('enableFieldValidators','approvalType', true)
				.bootstrapValidator('enableFieldValidators', 'approvalNo', true)
				//.bootstrapValidator('enableFieldValidators','appIssueAuth', true)
				.bootstrapValidator('enableFieldValidators', 'appFromDate', true)
				.bootstrapValidator('enableFieldValidators', 'appToDate',true);
	else
		$('#frm').bootstrapValidator('enableFieldValidators','approvalType', false)
				.bootstrapValidator('enableFieldValidators', 'approvalNo', false)
				//.bootstrapValidator('enableFieldValidators','appIssueAuth', false)
				.bootstrapValidator('enableFieldValidators', 'appFromDate', false)
				.bootstrapValidator('enableFieldValidators', 'appToDate',false);

}
function revalidateBootstrapFieldAppDtls() {
	$('#frm').bootstrapValidator('revalidateField','approvalType')
			.bootstrapValidator('revalidateField','approvalNo')
			//.bootstrapValidator('revalidateField','appIssueAuth')
			.bootstrapValidator('revalidateField','appFromDate')
			.bootstrapValidator('revalidateField', 'appToDate');

}

$(document).ready(function(){
	//alert("on load");
									$("#frm")
									.bootstrapValidator({
											fields : {
												siteType : {
									 				validators : {
									 					callback: {
									 				           message: 'Please specify site type',
									 				           callback: function(value, validator, $field) {
									 				               
									 				               var options = validator.getFieldElements('siteType').val();

									 				               return (options != 0);
									 				           }
									 					}
									 				}
											  }, 
											  premiseName : {
													validators : {
														notEmpty : {
															message : "Name is required and can't be empty"
														},
														regexp : {
															regexp : /^(?!.*\d{3})(?!.*[/.,()\-]{2})[a-zA-Z0-9().\/,\s\-]+$/,
															message : "Only alphabet, numbers, special characters( / , . () - ) and white spaces are permitted, consecutive special characters not allowed"
														},
														stringLength : {
															min : 5,
															max : 100,
															message : "Name can contain minimum 5 and maximum of 100 characters"
														}
													}
												},
												premiseAddress : {
													validators : {
														notEmpty : {
															message : "Address is required and can't be empty"
														},
														regexp : {
															regexp : /^(?!.*\d{3})(?!.*[/.,()\-]{2})[a-zA-Z0-9().\/,\s\-]+$/,
															message : "Only alphabet, numbers, special characters( / , . () - ) and white spaces are permitted, consecutive special characters not allowed"
														},
														stringLength : {
															min : 5 ,
															max : 250,
															message : "Address can contain maximum of 250 characters"
														}
													}
												},
												stateId : {
									 				validators : {
									 					callback: {
									 				           message: 'Please specify state',
									 				           callback: function(value, validator, $field) {
									 				               
									 				               var options = validator.getFieldElements('stateId').val();

									 				               return (options != 0);
									 				           }
									 					}
									 				}
											  }, 
											  districtId : {
									 				validators : {
									 					callback: {
									 				           message: 'Please specify district',
									 				           callback: function(value, validator, $field) {
									 				               
									 				               var options = validator.getFieldElements('districtId').val();

									 				               return (options != 0);
									 				           }
									 					}
									 				}
											  }, 
											  pinCode : {
													validators : {
														notEmpty : {
															message : "Pin Code is required and can't be empty"
														},
														regexp : {
															regexp : /^[0-9]*$/,
															message : 'Only numbers are permitted'
														},

														stringLength : {
															min : 6,
															max : 6,
															message : 'Pin Code can contain only 6 digits'
															/* message : 'Pin Code can contain maximum of 6 characters' */
														}
													}
												},
												contactNumber : {
													validators : {
														notEmpty : {
															message : "Phone number is required and can't be empty"
														},
														regexp : {
															regexp : /^[0-9]+$/,
															message : 'Only numbers are permitted'
														},

														stringLength : {
															/* min : 6,
															max : 20,
															message : 'Contact number can contain minimum of 6 characters maximum of 20 characters' */
															min : 10,
															max : 10,
															message : 'Phone number can contain 10 digits.'
														}
													}
												},
												emailId : {
													validators : {
														notEmpty : {
															message : "Email is required and can't be empty"
														},
														regexp : {
															regexp : '^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$',
															message : 'Please enter a valid email address'
														},
														stringLength : {
															min : 1,
															max : 50,
															message : "Email can contain maximum of 50 characters"
														}
													}
												},
												gstin : {
													validators : {
														regexp : {
															regexp : /\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}/,
															message : "Enter 15 characters, valid GSTIN Number"
														},
														stringLength : {
															min : 15,
															max : 15,
															message : "GSTIN can contain minimum of 15 and maximum of 15 characters"
														}
													}
												},
												gln : {//gs1
													validators : {
														regexp : {
															regexp : /^[0-9]+$/,
															message : "Only numbers(0-9) are permitted"
														},
														stringLength : {
															min : 13,
															max : 13,
															message : "GLN can contain minimum of 13 and maximum of 13 characters"
														}
													}
												},
												contactPersonName : {
													validators : {
														notEmpty : {
															message : "Name is required and can\'t be empty"
														},
														regexp: {
														    regexp: /^[a-zA-Z\s]+$/,
														    message: "Only alphabets and spaces are permitted"
														},
														stringLength : {
															min : 2,
															max : 50,
															message : "Name can contain maximum of 50 characters"
														}
													}
												},
												contPerMobileNo : {
													validators : {
														notEmpty : {
															message : "Mobile number is required and can\'t be empty"
														},
														regexp : {
															regexp : /^[0-9]*$/,
															message : 'Only numbers are permitted'
														},

														stringLength : {
/* 															min : 10,
															max : 10,
															message : 'Contact number can contain minimum 10 and maximum of 10 characters' */
															min : 10,
															max : 10,
															message : 'Mobile number can contain 10 digits'															
														}
													}
												},
												contactPerDesg : {
													validators : {
														notEmpty : {
															message : "Designation is required and can\'t be empty"
														},
														regexp: {
														    regexp: /^(?![0-9]{2,})(?!.*\d{2})[a-zA-Z0-9().\/,\s\-]+$/,
														    message: "Only alphabets, single numbers, special characters( / , . () - ) and spaces are permitted, and consecutive numbers are not allowed"
														},
														stringLength : {
															min : 2,
															max : 20,
															message : "Designation can contain maximum of 20 characters"
														}
													}
												},
												contPersEmail : {
													validators : {
														notEmpty : {
															message : "Email is required and can\'t be empty"
														},
														regexp : {
															regexp : '^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$',
															message : 'Please enter a valid email address'
														},
														stringLength : {
															min : 1,
															max : 50,
															message : "Email can contain maximum of 50 characters"
														}
													}
												},
												approvalType : {
									 				validators : {
									 					callback: {
									 				           message: 'Please specify Approval Type',
									 				           callback: function(value, validator, $field) {
									 				               
									 				               var options = validator.getFieldElements('approvalType').val();

									 				               return (options != 0);
									 				           }
									 					}
									 				}
											  },
											  approvalNo : {
													validators : {
														notEmpty : {
															message : "Approval Number is required and can\'t be empty"
														},
														regexp : {
															regexp : /^[a-zA-Z0-9().\/,\s\-]+(?<![/.,()-]{2})$/,
															message : "Only alphabet, numbers, special characters( / , . () - ) and white spaces are permitted, consecutive special characters not allowed"
														},			
														stringLength : {
															min : 2,
															max : 20,
															message : "Approval Number can contain maximum of 20 characters"
														}
													}
												},
												appFromDate : {
													selector : '#appFromDate',
													validators : {
														notEmpty : {
															message : 'The start Date is required'
														}
													}
												},
												appToDate : {
													selector : '#appToDate',
													validators : {
														notEmpty : {
															message : 'The end Date is required'
														}
													}
												},
												appIssueAuth : {
														validators : {
															notEmpty : {
																message : "Approving authority Name is required and can\'t be empty"
															},
															regexp : {
																regexp : /^[a-zA-Z]+$/,
																message : "Only alphabets and white spaces are permitted"
															},
															stringLength : {
																min : 2,
																max : 20,
																message : "Approving authority Name can contain maximum of 20 characters"
															}
														}
												},
												licType : {
									 				validators : {
									 					callback: {
									 				           message: 'Please specify license Type',
									 				           callback: function(value, validator, $field) {
									 				               
									 				               var options = validator.getFieldElements('licType').val();

									 				               return (options != 0);
									 				           }
									 					}
									 				}
											  },
											  licNo : {
													validators : {
														notEmpty : {
															message : "License number is required and can\'t be empty"
														},
														regexp : {
															regexp : /^[a-zA-Z0-9().\/,\s\-]+(?<![/.,()-]{2})$/,
															message : "Only alphabet, numbers, special characters( / , . () - ) and white spaces are permitted, consecutive special characters not allowed"
														},
														stringLength : {
															min : 2,
															max : 20,
															message : "License number can contain maximum of 20 characters"
														}
													}
												},
												fromDate : {
													selector : '#fromDate',
													validators : {
														notEmpty : {
															message : 'The start Date is required'
														}
													}
												},
												toDate : {
													selector : '#toDate',
													validators : {
														notEmpty : {
															message : 'The end Date is required'
														}
													}
												},
												issueAuth : {
														validators : {
															notEmpty : {
																message : "Issuing authority name is required and can\'t be empty"
															},
															regexp: {
															    regexp: /^[a-zA-Z\s]+$/,
															    message: "Only alphabets and spaces are permitted"
															},
															stringLength : {
																min : 2,
																max : 20,
																message : "Issuing authority name can contain maximum of 20 characters"
															}
														}
												},  
												faxNumber : {
													validators : {
														regexp : {
															regexp : /^[0-9]+$/,
															message : "Only numbers are permitted"
														},
														stringLength : {
															min : 6,
															max : 10,
															message : "FAX Number can contain minimum of 6 and maximum of 10 characters"
														}
													}
												}
												/* gs1 : {
													validators : {
														regexp : {
															regexp : /^[a-zA-Z0-9().\/,\s\-]+$/,
															message : "Only alphabet, numbers, special characters( / , . () - ) and white spaces are permitted"
														},
														stringLength : {
															min : 0,
															max : 20,
															message : "GS1 Number can contain maximum of 20 characters"
														}
													}
												} */
											}
										});

									
									
									/* $("#expSites").hide();
									$("#expLic").hide(); */
									$("#manuHead").show();
									$("#expHead").hide();
									if ('${applicant}' == 100) {
										//alert("manufacturer");
										$("#manuHead").show();
										$("#expHead").hide();
									}else if('${applicant}' == 101){
										//alert("exporter");
										$("#manuHead").hide();
										$("#expHead").show();
									}
									
									$("#approvalDetails").hide();		
									$("#checkBoxLimit").change(function(){
										if($(this).is(":checked")){
											//$("#limit_div").show();
											$("#approvalDetails").show();
										}
										else{
											$("#approvalDetails").hide();
										}
									});
	
	$('#addButton').click(function() {
		//alert("in add button");resetBootstrapFieldsLicDtls
		 var reg=/^[a-zA-Z0-9().\/,\s\-]+$/;

		enableBootstrapFieldsLicDtls(true);
		revalidateBootstrapFieldLicDtls();
		var licenseTypeText = $("#licType option:selected").text();
		var licenseType = $('#licType').val();
		var licenseNumber = $("#licNo").val();
		var issueAuthId = $('#issueAuth').val();
		var FromDate = $('#fromDate').val();
		var ToDate = $('#toDate').val();
		/* var document ; */

		if(!reg.test(licenseTypeText) || !reg.test(licenseType) || !reg.test(licenseNumber) || !reg.test(issueAuthId)){
			  alert("Special Characters not allowed");
			  return false;
		} 
		
		
		if (licenseTypeText == "" && licenseNumber == ""  && issueAuthId == "" && FromDate == "" && ToDate == "") {
			//error_message("Null Value Exits");
			alert("Null value Exist");
			chkVal = true;
			$('#tableBody').val("");
		} else {
			if (licenseTypeText != "" && licenseNumber != "" && issueAuthId != "" && FromDate != "" && ToDate != "") {
				var resultObject;
				var ArLength = addList.length;
				if (count >= 1) {
					//alert("1");
					resultObject = searchArray(licenseNumber, licenseTypeText, issueAuthId, FromDate, ToDate,addList);
					
				} else {
					$('#tableBody').append('<tr class="theadTransacColor"><th>License Type</th><th>License Number</th><th>Issuing Authority</th><th>From Date</th><th>To Date</th><th>Edit</th><th>Delete</th></tr>');
				}
				if (resultObject == true) {
					//$("#addButton").text("Update");
					//error_message("Batch is already exists");
					alert("License is already exist")
				} else if (editIndex != undefined) {
					document.getElementById("tableBody").deleteRow(editIndex + 1);
					addList.splice(editIndex, 1);
					editIndex = undefined;
					addList.push(new addtest(licenseTypeText, licenseType, licenseNumber, issueAuthId, FromDate, ToDate));
					$('#tableBody').append(
									'<tr><td>'
											+ addList[ArLength - 1].licenseTypeText
											+ '</td><td style="display:none;">'
											+ addList[ArLength - 1].licenseType
											+ '</td><td>'
											+ addList[ArLength - 1].licenseNumber
											+ '</td><td>'
											+ addList[ArLength - 1].issueAuthId
											+ '</td><td>'
											+ addList[ArLength - 1].FromDate
											+ '</td><td>'
											+ addList[ArLength - 1].ToDate
											+ '</td><td><button type="button" id="edit">Edit</button></td><td><button type="button" id="delete"  class="btn_default btn-danger">delete</button></td></tr>');
					clearFields();
				} else {
					addList.push(new addtest(licenseTypeText, licenseType, licenseNumber, issueAuthId, FromDate, ToDate));
					//alert(JSON.stringify(addList) +" ----->  "+addList.length +" -  count - "+count);
					clearFields();
				}
				$('#tableBody').append(
								'<tr><td>'
										+ addList[ArLength].licenseTypeText
										+ '</td><td style="display:none;">'
										+ addList[ArLength].licenseType
										+ '</td><td>'
										+ addList[ArLength].licenseNumber
										+ '</td><td>'
										+ addList[ArLength].issueAuthId
										+ '</td><td>'
										+ addList[ArLength].FromDate
										+ '</td><td>'
										+ addList[ArLength].ToDate
										+ '</td><td><button type="button" id="edit">Edit</button></td><td><button type="button" id="delete"  class="btn_default btn-danger">delete</button></td></tr>');
				count++;
			} else {
			}
		}
		});

			$("#tableBody").on("click","#edit",function() {
				//$("#addButton").text("Update");
				var resultArray = $(this).closest('tr').find('td').map(function() {
							return $(this).text();
						}).get();

				$('#licType option').each(function() {
						if ($.trim($(this).text().toLowerCase()) == $.trim(resultArray[0]).toLowerCase()) {
							$(this).prop("selected",false);
							$(this).prop('selected','selected');
						};								  
				});
			//alert(resultArray[0] +"  "+resultArray[1] +"  "+resultArray[2]+"  "+resultArray[3]+"  "+resultArray[4]+"  "+resultArray[5]);
				$('#licNo').val($.trim(resultArray[2]));

				$('#issueAuth').val($.trim(resultArray[3]));

				$('#fromDate').val($.trim(resultArray[4]));

				$('#toDate').val($.trim(resultArray[5]));
				
				
				//revalidateBootstrapField();
				//revalidateBootstrapFieldLicDtls();
				editIndex = indexArray(resultArray[2], addList);

			});
			$("#tableBody").on("click","#delete",function() {
					var resultArray = $(this).closest('tr').find('td').map(function() {
								return $(this).text();
							}).get();
					var index = indexArray(resultArray[2],addList);
					document.getElementById("tableBody").deleteRow(index + 1);
					addList.splice(index, 1);
					if (addList.length == 0)
						$("#addButton").text("Add");
					editIndex = undefined;
			});

//-------------------------------approval details------------------------------------------------------------------------------

			
			$('#appAddButton').click(function() {
				//alert("in add button");resetBootstrapFieldsAppDtls enableBootstrapFieldsAppDtls revalidateBootstrapFieldAppDtls
				 var reg=/^[a-zA-Z0-9().\/,\s\-]+$/;
				
				enableBootstrapFieldsAppDtls(true);
				revalidateBootstrapFieldAppDtls();
				var approvalTypeText = $("#approvalType option:selected").text();
				var approvalType = $('#approvalType').val();
				var approvalNumber = $("#approvalNo").val();
				//var appIssueAuthId = $('#appIssueAuth').val();
				var approvalFromDate = $('#appFromDate').val();
				var approvalToDate = $('#appToDate').val();
				
				
				if(!reg.test(approvalTypeText) || !reg.test(approvalType) || !reg.test(approvalNumber) /* || !reg.test(appIssueAuthId) */){
					  alert("Special Characters not allowed");
					  return false;
				} 

				if (approvalTypeText == "" && approvalNumber == "" /* && appIssueAuthId == "" */ && approvalFromDate == "" && approvalToDate == "") {
					//error_message("Null Value Exits");
					alert("Null value Exist")
					chkVal = true;
					$('#appTableBody').val("");
				} else {
					if (approvalTypeText != "" && approvalNumber != "" /* && appIssueAuthId != "" */ && approvalFromDate != "" && approvalToDate != "") {
						var resultObject;
						var ArLength = addListforApp.length;
						if (countforApp >= 1) {
							resultObject = searchArrayforApproval(approvalNumber, approvalTypeText, /* appIssueAuthId, */ approvalFromDate, approvalToDate,addListforApp);
							
						} else {
							//$('#appTableBody').append('<tr class="theadTransacColor"><th>Approval Type</th><th>Approval Number</th><th>Issueing Authority</th><th>From Date</th><th>To Date</th><th>Edit</th><th>Delete</th></tr>');
							$('#appTableBody').append('<tr class="theadTransacColor"><th>Approval Type</th><th>Approval Number</th><th>From Date</th><th>To Date</th><th>Edit</th><th>Delete</th></tr>');
						}
						if (resultObject == true) {
							//$("#addButton").text("Update");
							//error_message("Batch is already exists");
							alert("Approval is already exist")
						} else if (editIndexforApp != undefined) {
							document.getElementById("appTableBody").deleteRow(editIndexforApp + 1);
							addListforApp.splice(editIndexforApp, 1);
							editIndexforApp = undefined;
							addListforApp.push(new addtestforApproval(approvalTypeText, approvalType, approvalNumber, appIssueAuthId, approvalFromDate, approvalToDate));
							$('#appTableBody').append(
											'<tr><td>'
													+ addListforApp[ArLength - 1].approvalTypeText
													+ '</td><td style="display:none;">'
													+ addListforApp[ArLength - 1].approvalType
													+ '</td><td>'
													+ addListforApp[ArLength - 1].approvalNumber
													/* + '</td><td>'
													+ addListforApp[ArLength - 1].appIssueAuthId */
													+ '</td><td>'
													+ addListforApp[ArLength - 1].approvalFromDate
													+ '</td><td>'
													+ addListforApp[ArLength - 1].approvalToDate
													+ '</td><td><button type="button" id="appEdit">Edit</button></td><td><button type="button" id="appDelete" class="btn_default btn-danger">delete</button></td></tr>');
							clearFieldsforApproval();
						} else {
							addListforApp.push(new addtestforApproval(approvalTypeText, approvalType, approvalNumber, /* appIssueAuthId, */ approvalFromDate, approvalToDate));
							//alert(JSON.stringify(addListforApp) +" ----->  "+addListforApp.length +" -  count - "+countforApp);
							clearFieldsforApproval();
						}
						$('#appTableBody').append(
										'<tr><td>'
												+ addListforApp[ArLength].approvalTypeText
												+ '</td><td style="display:none;">'
												+ addListforApp[ArLength].approvalType
												+ '</td><td>'
												+ addListforApp[ArLength].approvalNumber
												/* + '</td><td>'
												+ addListforApp[ArLength].appIssueAuthId */
												+ '</td><td>'
												+ addListforApp[ArLength].approvalFromDate
												+ '</td><td>'
												+ addListforApp[ArLength].approvalToDate
												+ '</td><td><button type="button" id="appEdit">Edit</button></td><td><button type="button" id="appDelete"  class="btn_default btn-danger">delete</button></td></tr>');
						countforApp++;
					} else {
					}
				}
				});

					$("#appTableBody").on("click","#appEdit",function() {
						//$("#addButton").text("Update");
						var resultArray = $(this).closest('tr').find('td').map(function() {
									return $(this).text();
								}).get();

						$('#approvalType option').each(function() {
							if ($.trim($(this).text().toLowerCase()) == $.trim(resultArray[0]).toLowerCase()) {
								$(this).prop("selected",false);
								$(this).prop('selected','selected');
							};								  
						});

						$('#approvalNo').val($.trim(resultArray[2]));

						/* $('#appIssueAuth').val($.trim(resultArray[3])); */

						$('#appFromDate').val($.trim(resultArray[3]));

						$('#appToDate').val($.trim(resultArray[4]));
						
					
						
						
						//revalidateBootstrapField();
						revalidateBootstrapFieldAppDtls();
						editIndexforApp = indexArrayforApproval(resultArray[2], addListforApp);

						//alert(editIndexforApp);

					});
					$("#appTableBody").on("click","#appDelete",function() {
							var resultArray = $(this).closest('tr').find('td').map(function() {
										return $(this).text();
									}).get();
							var index = indexArrayforApproval(resultArray[2],addListforApp);
							document.getElementById("appTableBody").deleteRow(index + 1);
							addListforApp.splice(index, 1);
							if (addListforApp.length == 0)
								$("#appAddButton").text("Add");
							editIndexforApp = undefined;
					});

//------------------------------save functionalities-----------------------------------------------------------------------------

			$('#save').click(function() {
				var addedList_String = JSON.stringify(addList);
				$("#addedList_str").val(addedList_String);

				var appAddedList_String = JSON.stringify(addListforApp);
				//alert(appAddedList_String);
				$("#appAddedList_str").val(appAddedList_String);

				var bV = $("#frm").data('bootstrapValidator');
				   bV.validate();
					if(bV.isValid()){ 
						confirm_alert('Do you Really want to save?','save');
					}
					else{}
			});

			$('#saveAppType').click(function() {
				var type = $('#strApprovalType').val();
				var remarks = $('#strApprovalTypeRemarks').val();
				if(type == ""){
					error_message("Please Fill the required feild.")
				}else{
					confirm_alert('Do you Really want to save?','saveApproval');
				}
				
			});

			
			/* if('${flagSave}'== 1){
				ok_message("New Record Added Successfully.");
			} */

//================================Edit code from JSON================================
	//alert('${backFromPreview}');
	//if('${backFromPreview}' == 1){
		/* var addListController = '${manufacturingSiteListAfterSave}';
		alert("manufacturingSiteListAfterSave  save "+ addListController);
		var addListParsed = JSON.parse(addListController);
		alert("parsed json ========      "+addListParsed);
		alert("parsed json length ========      "+addListParsed.length);
		var stringData = JSON.stringify(addListController);
		alert("Simple JSON Stringify     "+stringData);
		var stringDataJSON = JSON.stringify(addListParsed);
		alert("stringData JSON Stringtigy    =======   "+stringDataJSON);
		alert("stringData JSON Stringtigy  length  =======   "+stringDataJSON.length);
		alert("stringData sitetype     =======   "+stringDataJSON[0].sitetype);
		
		for (var i = 0; i <= stringData.length; i++) {
			
		} */

		//var premiseDtls = '${premisedata}';
		//alert('${premisedata}');
		//alert('${premisedata.siteType}');
	//} 
	
			//Govind's edit to remove the ERROR OF SUBMITTING FORM AFTER PRESSING ENTERY ON EMPTY FIELD
			$(window).keydown(function(event){
			  if(event.keyCode == 13) {
			    event.preventDefault();
			    return false;
			  }
			});

	
});

function loadDistrict(){ 
	var stateId=$('#stateId').val(); 
	/*  if(stateId !=0)
     {

       $('#frm').bootstrapValidator('enableFieldValidators', 'stateId', false);


     } */
	
	 $('#distId')
                 .find('option')
                 .remove()
                 .end();
          $('#distId').append($("<option></option>").attr("value","0").text("--select Premises District--"));
                 
		$.ajax({
			type : "GET",
			 url : "getDistrictData",
			data : {stateId:stateId},
		 success : function(response){
			 if(response.length>0){
				
				 for(var userlist in response){
					 $('#distId').append($("<option></option>").attr("value",response[userlist].num_district_id).text(response[userlist].str_district_name));
				 }  
				 
			 }
		 }
	});
}

function addAppAgency(){
	var id = $('#approvalType').val(); 
	
	//alert(id);
	if(id == 1){
		showModal('#modelForAddAppType');
	}else{
		
	}
}

function showModal(event) {
	//alert("in show modal");
	$(event).modal({
		backdrop : 'static',
		keyboard : false,
		show : true

	});
} 

function  confirm_alert(msg,type){
	var m = msg.split('.');
	    var msg1=m[0];
	    msg2=m[1];
		swal(
				{  		
				title: "Are you sure?",   text: msg1,   
				type: "warning",  
				showCancelButton: true,   
				confirmButtonColor: "#34A534",   
				confirmButtonText: "OK",   
				cancelButtonText: "Cancel",   
				closeOnConfirm: true,   
				closeOnCancel:true 
				}, 
				function(isConfirm){   
				    	  if (isConfirm) {
				    		  
				    		  if(type=="save")
								{				
								submit_form();
								}
							else if(type=="delete")
								{
								 flag=true; 
								submit_form_delete();
								}
							else if(type=="modify")
							{
								submit_form_update();
							}
							else if(type=="saveApproval")
							{
								submit_form_forAppType();
							}
							else if(type=="ok")
							{
								 flag=true; 
								submit_form_delete();	
								}
					    	  } 

				    	  else {
				    		  imp=false;
				    	  }
				    	});
}

function submit_form(){
	document.getElementById("frm").action = "${pageContext.request.contextPath}/saveInstPremisesAddressDetails" 
	document.getElementById("frm").method = "POST";
	$("#frm").submit();
}

function submit_form_forAppType(){
	var type = $('#strApprovalType').val();
	var remarks = $('#strApprovalTypeRemarks').val();
	//alert(type+"  "+remarks);

	/* DwrServiceImpl.saveApprovalTypeMst(type,remarks,function(data){

		alert(data);
		}); */

	$.ajax({
		type: "GET",
        url: "saveAppTypeMst",
        data: {type: $('#strApprovalType').val(),remarks: $('#strApprovalTypeRemarks').val()},
	    success:function(result){
	  		//alert("result"+result);
	  		$('#modelForAddAppType').modal('toggle');
	  		location.reload(true);
		}
	});
}


</script>
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-RRHHYLSBGG"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-RRHHYLSBGG');
</script>
</head>

<body>
    <div class="content-wrapper pt-0 mt-0">
        <section class="regdv content content-tiles">
            <div class="page-title reg_col" id="manuHead">
                <h1 class="fw-bold">Add Manufacturing Site Details</h1>
            </div>
            <div class="page-title" id="expHead">
                <h1 class="fw-bold">Add Wholesale Site</h1>
            </div>

            <div class="p-0">
                <form:form method="post" id="frm" name="frm" modelAttribute="registrationForm" autocomplete="off">
                    <c:forEach items="${errors }" var="error">
                        <div class="alert alert-success" role="alert">
                            <button type="button" class="close" data-bs-dismiss="alert" aria-label="Close">
								<i class="fa fa-times-circle" aria-hidden="true">
		                          <span class="sr-only">Close</span>
		                      	</i>
							</button>

                            <div class="text-danger">
                                <c:out value="${error }"></c:out>
                            </div>
                        </div>
                    </c:forEach>
                    <form:hidden id="addedList_str" path="addedList_str" />
                    <form:hidden id="appAddedList_str" path="appAddedList_str" />
                    <sec:csrfInput />

                    <div class="panel panel-default" id="addressDetails">
                        <div class="panel-heading bluepanel medium bold panel-sfda dvfrm-panel-heading">
                            <b>Premises Address Details</b>
                        </div>
                        <div class="panel-body dvfrm-panel-body">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col" id="manuSites">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="siteTypeId">Premises Type:<span style="color:#cd2026;">*</span></label>
                                        <form:select path="siteType" class="form-control" id="siteTypeId">
                                            <form:option value="0">Select Premises Type</form:option>
                                            <c:forEach items="${site}" var="c">
                                                <option value='${c.numSiteTypeId}'> ${c.siteTypeName}</option>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                </div>


                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="preName">Premises Name:<span tyle="color: red;">*</span></label>
                                        <form:input path="premiseName" type="text" class="form-control" id="preName"
                                            placeholder="Enter Premises Name" />
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="address">Premises Address: <span style="color:#cd2026;">*</span></label>
                                        <form:input path="premiseAddress" type="text" class="form-control" id="address"
                                            placeholder="Enter Premises Address" />
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="stateId">State:<span style="color:#cd2026;">*</span></label>
                                        <form:select path="stateId" class="form-control" id="stateId"
                                            onchange="loadDistrict();">
                                            <form:option value="0">--select Premises State--</form:option>
                                            <c:forEach items="${state}" var="c">
                                                <option value='${c.num_state_id}'>
                                                    ${c.str_state_name}</option>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="distId">District:<span style="color:#cd2026;">*</span></label>
                                        <form:select path="districtId" class="form-control" id="distId">
                                            <form:option value="0">--select Premises District--</form:option>
                                        </form:select>
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="pincode">Zip/Postal Code:<span style="color:#cd2026;">*</span></label>
                                        <form:input path="pinCode" type="text" class="form-control" id="pincode"
                                            placeholder="Enter Zip/Postal Code" />
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="contactNumber">Premise's Phone Number:<span
											style="color:#cd2026;">*</span></label>
                                        <form:input path="contactNumber" type="text" class="form-control"
                                            id="contactNumber" placeholder="Enter Contact Number" />
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="faxNumber">Premises Fax Number:</label>
                                        <form:input path="faxNumber" type="text" class="form-control" id="faxNumber"
                                            placeholder="Enter Fax Number" />
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="emailId">Premises Email Id:<span
											style="color:#cd2026;">*</span></label>
                                        <form:input path="emailId" type="text" class="form-control" id="emailId"
                                            placeholder="Enter Email Id" />
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="gstin">Premises GSTIN No.:</label>
                                        <form:input path="gstin" type="text" class="form-control" id="gstin"
                                            onblur="checksum(this.value)" placeholder="Enter GSTIN Number" />
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="gln">Premises GLN No.:</label>
                                        <form:input path="gln" type="text" class="form-control" id="gln"
                                            onblur="checkdigit(this.value)" placeholder="Enter GLN Number" />
                                    </div>
                                </div>
                            </div>
                            <!--end row-->
                        </div>
                        <!--end panel body-->
                    </div>
                    <!--end panel-->

                    <!-- Contact Person details -->
                    <div class="panel panel-default " id="personDetails">
                        <div class="panel-heading bluepanel medium bold panel-sfda dvfrm-panel-heading">
                            <b>Premises Contact Person Details</b>
                        </div>
                        <div class="panel-body dvfrm-panel-body">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="contactPersonName">Name:<span style="color:#cd2026;">*</span></label>
                                        <form:input path="contactPersonName" type="text" class="form-control"
                                            id="contactPersonName" placeholder="Enter Contact Person Name" />
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="contPerMobileNo">Mobile Number:<span style="color:#cd2026;">*</span></label>
                                        <form:input path="contPerMobileNo" type="text" class="form-control"
                                            id="contPerMobileNo" placeholder="Enter Contact Person Mobile Number" />
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="contactPerDesg">Designation:<span
											style="color:#cd2026;">*</span></label>
                                        <form:input path="contactPerDesg" type="text" class="form-control"
                                            id="contactPerDesg" placeholder="Enter Contact Person Designation" />
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="contPersEmail">Email Id:<span
											style="color:#cd2026;">*</span></label>
                                        <form:input path="contPersEmail" type="text" class="form-control"
                                            id="contPersEmail" placeholder="Enter Contact Person Email Id" />
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default " id="">
                        <div class="panel-heading bluepanel medium bold panel-sfda dvfrm-panel-heading">
                            <b>Global Regulatory Approval Details</b>
                        </div>
                        <div class="panel-body dvfrm-panel-body">
                            <div class="col-md-12 col">
                                <label class="dvfrm-label" for="checkBoxLimit">Does Global
									Regulatory Approval Details applicable? :</label>
                                <input type="checkbox" id="checkBoxLimit">
                            </div>
                        </div>
                    </div>

                    <!-- Approval details -->
                    <div class="panel panel-default " id="approvalDetails">
                        <div class="panel-heading bluepanel medium bold panel-sfda dvfrm-panel-heading">
                            <b>Please click add button to add more Approval details.</b>
                        </div>
                        <div class="panel-body dvfrm-panel-body">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="approvalType">Approving Agency:<span style="color:#cd2026;">*</span><span class="iconStyle"
											cssStyle="inline tooltip"
											title="If you want to add approving agency please select other option and add approvig agencies.">
												?</span></label>
                                        <form:select path="approvalType" class="form-control" id="approvalType"
                                            onchange="addAppAgency();">
                                            <form:option value="0">--select Agency Name--</form:option>
                                            <c:forEach items="${app}" var="c">
                                                <option value='${c.numAppTypeId}'>
                                                    ${c.strAppTypeName}</option>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="approvalNo">Certificate/Approval No:<span style="color:#cd2026;">*</span><span class="iconStyle"></span></label>
                                        <form:input path="approvalNo" type="text" class="form-control" id="approvalNo"
                                            placeholder="Enter Certificate/Approval Number" />
                                    </div>
                                </div>


                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="appFromDate">Valid From<span style="color:#cd2026;">*</span></label>
                                        <div class="form-group">
                                            <div class='input-group date' id=''>
                                                <form:input path="appFromDate" type="date" class="form-control" value=""
                                                    id="appFromDate" placeholder="" onchange="checkAppDate();" />

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12 col">
                                    <div class="form-group">
                                        <label class="dvfrm-label" for="appToDate">Valid Upto<span style="color:#cd2026;">*</span></label>
                                        <div class="form-group">
                                            <div class='input-group date' id=''>
                                                <form:input path="appToDate" type="date" class="form-control" value=""
                                                    id="appToDate" placeholder="" onchange="checkAppDate();" />

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%-- <div class=" col-md-6">
                                    <label class="dvfrm-label">Issuing Authority:<span style="color:red;">*</span><span class="iconStyle"></span></label>
                                    <form:input path="appIssueAuth" type="text" class="form-control" id="appIssueAuth"
                                        placeholder="Enter Issuing Authority Name" />
                            </div> --%>
                        </div>
                    </div>

                    <div class="col-md-12 text-center col">
                        <button type="button" class="custom-btn position-relative" id="appAddButton">Add</button>
                    </div>
            </div>

            <table id="appTableBody"
                class="table table-striped table-bordered display table-responsive table-responsive-bordered"
                style="overflow-x: auto;">
                <thead class="theadTransacColor">

                </thead>
                <tbody>

                </tbody>
            </table>

            <!-- License details -->
            <div class="panel panel-default " id="licenseDetails">
                <div class="panel-heading bluepanel medium bold panel-sfda dvfrm-panel-heading">
                    <b>License Details</b><span>
								<h4>Please Click Add button to add more License Details.</h4>
							</span>
                </div>
                <div class="panel-body dvfrm-panel-body">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12 col">
                            <div class="form-group">
                                <label class="dvfrm-label" for="licType">License Type:<span
											style="color:#cd2026;">*</span></label>
                                <form:select path="licType" class="form-control" id="licType">
                                    <form:option value="0">--select License Type--</form:option>
                                    <c:forEach items="${lic}" var="c">
                                        <option value='${c.numLicenseTypeId}'>
                                            ${c.licenseTypeName}</option>
                                    </c:forEach>
                                </form:select>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12 col">
                            <div class="form-group">
                                <label class="dvfrm-label" for="licNo">License No.:<span
											style="color:#cd2026;">*</span><span class="iconStyle"></span></label>
                                <form:input path="licNo" type="text" class="form-control" id="licNo"
                                    placeholder="Enter License Number" />
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12 col">
                            <div class="form-group">
                                <label class="dvfrm-label" for="fromDate">Valid From<span
										style="color:#cd2026;">*</span></label>
                                <div class='input-group date' id=''>
                                    <form:input path="fromDate" type="date" class="form-control" value="" id="fromDate"
                                        placeholder="" onchange="checkLicDate();" />

                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12 col">
                            <div class="form-group">
                                <label class="dvfrm-label" for="toDate">Valid Upto<span
											style="color:#cd2026;">*</span></label>
                                <div class="form-group">
                                    <div class='input-group date' id=''>
                                        <form:input path="toDate" type="date" class="form-control" value="" id="toDate"
                                            placeholder="" onchange="checkLicDate();" />

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12 col">
                            <div class="form-group">
                                <label class="dvfrm-label" for="issueAuth">Issuing Authority:<span
											style="color:#cd2026;">*</span></label>
                                <form:input path="issueAuth" type="text" class="form-control" id="issueAuth"
                                    placeholder="Enter Issuing Authority Name" />
                            </div>
                        </div>

                        <%-- <div class="col-lg-6">
                            <form:hidden path="numDocId" id="numDocId" />
                            <form:hidden path="strDocId" id="strDocId" value="-1" />
                            <label class="label-class">Document</label>
                            <div id="idUpload">
                                <input class="form-control" id="fileupload"
											type="file" accept="application/pdf" />
                            </div>
                            <div id="fileuploadRemove">
                                <a id="fileuploadDownloadLink" href="#">download</a>
                                <button type="button" id="fileuploadRemoveBtn" class="btn-primary"
												onclick="showAppFile('fileuploadRemove','fileupload')">Remove</button>
                            </div>
                    </div> --%>
                    <div class="col-md-12 text-center col">
                        <button type="button" class="custom-btn position-relative" id="addButton">Add</button>
                    </div>
                </div>
            </div>
    </div>

    <div class="col-md-12">
        <table id="tableBody"
            class="table table-striped- table-bordered table-hover table-checkable table-responsive table-responsive-bordered">
            <thead class="theadTransacColor">

            </thead>
            <tbody>

            </tbody>
        </table>
    </div>


					<!-- G-CODE -- File Upload Functionality -->
					<div class="panel panel-default">

						<div
							class="panel-heading bluepanel medium bold panel-sfda dvfrm-panel-heading">
							<b>Upload All Drug License Details</b><span>
								<h4>Please Click Add button to upload License Details.</h4>
							</span>
						</div>

						<div class="col-lg-6 col-md-6 col-sm-12 col">
							<div class="form-group"></div>
							<!-- START -->
										<form:hidden path="numDocId" id="numDocId"/>
				                		<form:hidden path="strDocId" id="strDocId"  value="-1" /> 
										<form:hidden path="numDocumentId" id="hppGeneratedData2"/>
										<form:hidden path="strExpType" id="hashValue2"/> 
										<label class="dvfrm-label" for=drugLicence>Upload Drug Licenses:<span style="color:#cd2026;">*</span><span class="iconStyle"></span></label>
										<input type="file" class="form-control" name="drugLicence" id="drugLicence" placeholder="Please upload pdf only" 
												accept="application/pdf" onchange="fileValidation(this.id);getdrugChecksum();filechecksumm()"/>
										<input type="hidden" name="drugLiecenseDocument" id="drugLiecenseDocument" aria-label="drugLiecenseDocument">	
                           <!-- END -->													                									
						</div>
					</div>
					<!-- G-CODE-END -->
					
					
    <div class="text-center m-0">
        <button type="button" class="custom-btn position-relative btn-success" id="save">
							Save</button>
        <button type="reset" class="btn_default" id="reset">
							Reset</button>
    </div>

    </form:form>
    </div>

    <div class="modal modallg fade seminor-login-modal" data-backdrop="static" id="modelForAddAppType"
        data-easein="slideDownBigIn">
        <div class="modal-dialog modal-dialog-centered modal_wd">
            <div class="modal-content">

                <div class="modal-header theadTransacColor">
                    <h3 class="modal-title">Add Approving Agency</h3>
                    <button type="button" class="close" data-bs-dismiss="modal">
									<i class="fa fa-times-circle" aria-hidden="true">
		                          	<span class="sr-only">Close</span>
		                      		</i>
								</button>
                </div>
                <div class="modal-body">
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group">
                                <div class=" col-md-6">
                                    <label class="dvfrm-label" for="strApprovalType">Enter the Name of the
													Regulatory/Approving Agency:<span style="color:#cd2026;">*</span><span
													class="iconStyle"></span>
												</label> <input name="strAppType" type="text" class="form-control"
													id="strApprovalType" placeholder="Enter Approving type" />
                                </div>
                                <div class=" col-md-6">
                                    <label class="dvfrm-label" for="strApprovalTypeRemarks">Remarks:<span
													class="iconStyle"></span></label>
                                    <textarea name="appTypeRemarks" class="form-control"
													id="strApprovalTypeRemarks"
													placeholder="Enter Approving type remarks"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="saveAppType"
									class="btn btn-primary m-btn--wide" value="forward">
									<i class="fa fa-location-arrow" style="padding-right: 15%"></i>
									Submit
								</button>
                    <button type="button" class="btn btn-primary m-btn--wide"
									data-dismiss="modal">
									<i class="flaticon-circle" style="padding-right: 15%"></i>Close
								</button>

                </div>
            </div>
        </div>
    </div>
    </section>
    </div>

<script>
function fileValidation(id) {
	//alert("1. Function --- In fileValidation");
	var fileInput = document.getElementById(id);
    var file = fileInput.files[0];
    var filePath = fileInput.value;	    
    var allowedExtensions = /(\.pdf)$/i;
	if(!allowedExtensions.exec(filePath)){
	        alert('Please upload file having extensions .pdf only.');
	        fileInput.value = '';
	        return false;
	}
    if (file) {
        var fileSizeInBytes = file.size;
        var fileSizeInMB = fileSizeInBytes / (1024 * 1024); // Convert bytes to MB
        //alert("File size: " + fileSizeInMB.toFixed(2) + " MB");
        if(fileSizeInMB > 10){
        	alert("Please upload file having size less than 10MB");
        	fileInput.value = ''; // Clear the input value
        	return false;
        }
    } else {
       
    }
}

function getdrugChecksum() {
	//alert("2. Function --- In getdrugChecksum");	
	var form = $('#frm')[0];
	var data = new FormData(form);
	$.ajax({
		type: "POST",
		url: "getdrugChecksum",
		enctype: 'multipart/form-data',
		data: data,
		cache: false,
		processData: false,
		contentType: false,
		timeout: 600000,
		success: function(response) {
			console.log("Response:", response); // Print response in console log
			if (response.length > 0) {
				$('#drugLiecenseDocument').val(response);
			} else {
				alert("Error");
			}
		}
	});
}

function filechecksumm() {
	//alert("3. Function -- filechecksumm");
	var reader = new FileReader();
	reader.onload = readSuccess1; // calling the readSuccess1
	var fileInput = $("[type='file']")[0];
	var fileToRead = fileInput.files[0];
    if (fileToRead) {
        reader.readAsDataURL(fileToRead);
    }
};
	
function readSuccess1(evt) {
		//alert("3.a. Function -- readSuccess1");
		var tempData = evt.target.result;
		var b64d = tempData.split(',')[1].replace(/[\r\n]/g, '');
		var inputCode = getInputCode(b64d);
		console.log("inputCode -- "+inputCode);
		var origHPPCode = "file123#$";
		var hppGeneratedData = getHPPCodee(origHPPCode, inputCode % 1000);
		$('#hppGeneratedData2').val(hppGeneratedData);
		console.log("hppGeneratedData -- "+hppGeneratedData);
		var somecheck=$('#drugLicence').val().toString();
		console.log("somecheck -- "+somecheck);		
		var path = somecheck.toString();
		var altpath=somecheck+hppGeneratedData;
		console.log("altpath -- "+altpath);
		var r1=btoa(altpath);
		var r2=reverseString(r1);
		var r3=btoa(r2);
		$('#hashValue2').val(r3);
		console.log("hppGeneratedData -- "+hppGeneratedData);
		return hppGeneratedData
};

function getInputCode(input) {
		//alert("3.a.1. Function -- getInputCode");
		var output = 0;
		for (var i = 0; i < input.length; i++) {
			var c = input.charCodeAt(i) + i;
			output += c;
		}
		console.log("output -- "+output);
		return output;
}

function getHPPCodee(hppCode, inputCode) {
		//alert("3.a.2. Function -- getHPPCodee");
		var n = parseInt(inputCode);
		for (var i = 0; i < n; i++) {
			hppCode = encode(hppCode, 3);
		}
		console.log("hppCode -- "+hppCode);
		return hppCode;
}
function reverseString(str) {
	//alert("3.a.3. Function -- reverseString")
    var newString = "";
    for (var i = str.length - 1; i >= 0; i--) {
        newString += str[i];
    }
    console.log("newString -- "+newString);
    return newString;
}

function encode(input, key) {
		var output = "";
		for (var i = 0; i < input.length; i++) {
			var c = input.charCodeAt(i);
			if (c >= 65 && c <= 90) {
				output += String.fromCharCode((c - 65 + key) % 26 + 65);
			} else if (c >= 97 && c <= 122) {
				output += String.fromCharCode((c - 97 + key) % 26 + 97);
			} else {
				output += input.charAt(i); // Copy
			}
		}
		return output;
	}

function getSignatureChecksum() {
		var form = $('#frm')[0];
		var data = new FormData(form);
		$.ajax({
			type: "POST",
			url: "getSignatureChecksum",
			enctype: 'multipart/form-data',
			data: data,
			cache: false,
			processData: false,
			contentType: false,
			timeout: 600000,
			success: function(response) {
				if (response.length > 0) {
					$('#drugLiecenseDocument').val(response);
				} else {
					alert("Error");
				}
			}
		});
}
</script>

    
</body>
</html>