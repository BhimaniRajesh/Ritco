<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DriverDetVer1.aspx.cs" Inherits="GUI_Fleet_Webadmin_Driver_DriverDetVer1" %>

<%@ Register Src="~/GUI/Common_UserControls/DatePicker2.ascx" TagName="DTP" TagPrefix="DateP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

	<script language="javascript" type="text/javascript">
		var hdfLocation, hdfStatus, hdfState, ddlLocation, cboStatus, ddlstate;
		$(document).ready(function () {
			ddlLocation = $("#ctl00_MyCPH1_ddlLocation");
			vcboStatus = $("#ctl00_MyCPH1_cboStatus");
			ddlstate = $("#ctl00_MyCPH1_ddlstate");
			hdfLocation = $("#ctl00_MyCPH1_hdfLocation");
			hdfStatus = $("#ctl00_MyCPH1_hdfStatus");
			hdfState = $("#ctl00_MyCPH1_hdfState");
			ddlLocation.select2();
			ddlLocation.val(hdfLocation.val()).trigger("change");
			vcboStatus.select2();
			vcboStatus.val(hdfStatus.val()).trigger("change");
			ddlstate.select2();
			ddlstate.val(hdfState.val()).trigger("change");

		});

		function nwOpen(mNo) {
			window.open("PopupVehicleNo.aspx?mNo=" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
		}
		function VehicleHistory() {
			var VehicleNo = document.getElementById("ctl00_MyCPH1_txtVehicleNo").value;
			window.open("VehicleHistoryReport.aspx?VehicleNo=" + VehicleNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
		} 
		function test() {
			//alert(1);
		}
		function popupMe(strFile) {
			//ctl00_MyCPH1_LblEBill
			var mstrFile = document.getElementById("ctl00_MyCPH1_" + strFile).innerText
			var mFilePath = "http://ritco-tms.southeastasia.cloudapp.azure.com/RitcoLog_Live/UploadedImages/" + mstrFile;
			window.open(mFilePath, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
		}
		function storeValueInHidden(controlId, Hidden) {
			var HiddenId = $("#ctl00_MyCPH1_" + Hidden);
			var controlId = $("#" + controlId);
			HiddenId.val(controlId.val());
			return false;
		}
		function IsvalidAge(DateValue1, DateValue2) {
			debugger;
			var a = DateValue1.split("/");
			var b = DateValue2.split("/");
			var CurrentYear = parseInt(a[2]);
			var DOB = parseInt(b[2]);
			if ((CurrentYear - DOB) <= 18) {
				return false;
			}
			return true;
		}
		function CHECKVALID() {
			var txtDriverName = document.getElementById("ctl00_MyCPH1_txtDriverName");
			var txtFather = document.getElementById("ctl00_MyCPH1_txtFather");
			var txtContact = document.getElementById("ctl00_MyCPH1_txtContact");
			var txtValDt = document.getElementById("ctl00_MyCPH1_txtValDt_txtDate");
			var txtRTO = document.getElementById("ctl00_MyCPH1_txtRTO");
			var txtVillageMobileNo = document.getElementById("ctl00_MyCPH1_txtVillageMobileNo");
			var txtReferenceName = document.getElementById("ctl00_MyCPH1_txtReferenceName");
			var txtReferenceMobileNo = document.getElementById("ctl00_MyCPH1_txtReferenceMobileNo");
			var txtAadharCardNo = document.getElementById("ctl00_MyCPH1_txtAadharCardNo");
			var FilePhoto = document.getElementById("ctl00_MyCPH1_FilePhoto");
			var FileDriverBioData = document.getElementById("ctl00_MyCPH1_FileDriverBioData");
			var FileAadharCard = document.getElementById("ctl00_MyCPH1_fileAadharCardNo");
			var LblAadharCardNo = document.getElementById("ctl00_MyCPH1_LblAadharCardNo");
			var lblPhoto = document.getElementById("ctl00_MyCPH1_lblPhoto");
			var lblDriverBioData = document.getElementById("ctl00_MyCPH1_lblDriverBioData");
			var txtDOB = document.getElementById("ctl00_MyCPH1_txtDOB_txtDate");
			var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
			var txtVehicleNo = document.getElementById("ctl00_MyCPH1_txtVehicleNo");

			if (txtVehicleNo.value == "") {
				alert("Please Enter Vehicle No.");
				txtVehicleNo.focus();
				return false;
			}

			if (!IsvalidAge(hfTodayDate.value, txtDOB.value)) {
				alert("Please Enter Valid Date Of Birth(Minimum 18 Year)");
				txtDOB.focus();
				return false;
			}
			if (txtDriverName.value == "") {
				alert("Please Enter Driver Name.");
				txtDriverName.focus();
				return false;
			}
			if (txtFather.value == "") {
				alert("Please Enter Driver Father Name.");
				txtFather.focus();
				return false;
			}
			if (txtContact.value == "") {
				alert("Please Enter Driver Mobile No.");
				txtContact.focus();
				return false;
			}
			if (txtValDt.value == "") {
				alert("Please Enter D/L Validity.");
				txtValDt.focus();
				return false;
			}
			if (txtRTO.value == "") {
				alert("Please Enter Issued By RTO.");
				txtRTO.focus();
				return false;
			}
			if (txtVillageMobileNo.value == "") {
				txtVillageMobileNo.focus();
				alert("Please Enter Village Mobile No.");
				return false;
			}
			if (txtReferenceName.value == "") {
				alert("Please Enter EnterReference Name.");
				txtReferenceName.focus();
				return false;
			}
			if (txtReferenceMobileNo.value == "") {
				alert("Please Enter Reference Mobile No.");
				txtReferenceMobileNo.focus();
				return false;
			}

			if (txtAadharCardNo.value == "") {
				alert("Please Enter Aadhar Card No.");
				txtAadharCardNo.focus();
				return false;
			}

			if (txtAadharCardNo.value.length != "12") {
				alert("Please Enter Valid Aadhar Card No.");
				txtAadharCardNo.focus();
				return false;
			}

			if (FileAadharCard.value == "") {
				if (LblAadharCardNo.innerText == "") {
					alert("Please upload Driver Aadhar Card.");
					FileAadharCard.focus();
					return false;
				}
			}

			if (FilePhoto.value == "") {
				if (lblPhoto.innerText == "") {
					alert("Please upload Driver Photo.");
					FilePhoto.focus();
					return false;
				}
			}
			if (FileDriverBioData.value == "") {
				if (lblDriverBioData.innerText == "") {
					alert("Please upload Driver Bio Data.");
					FileDriverBioData.focus();
					return false;
				}

			}
			var txtPanNo = document.getElementById("ctl00_MyCPH1_txtPANCardNo");
			if (txtPanNo.value == "") {
				alert("Please Enter Pan Card Number.");
				txtPanNo.focus();
				return false;
			}
			else {
				if (txtPanNo.value.length < 10) {
					alert("Pan card number should be 10 digit long.");
					txtPanNo.focus();
					return false;
				}
				else {
					if (!isNaN(txtPanNo.value)) {
						alert("Only Numbers are not allowed.");
						txtPanNo.value = "";
						txtPanNo.focus();
						return false;
					}
				}
			}
			return true;
		}
	</script>
	<div>
		<table cellspacing="1" style="width: 100%">
			<tr style="background-color: white">
				<td align="left">
					<asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Driver Master</asp:Label>
					<hr align="center" size="1" color="#8ba0e5">
				</td>
			</tr>
		</table>

		<br />
		<table cellspacing="1" cellpadding="3" width="900px" class="boxbg">
			<tr style="background-color: white">
				<td colspan="4" align="left">
					<asp:Label ID="lblErrMsg" runat="server" Text="" CssClass="blackfnt" Font-Bold="true" ForeColor="red" Visible="true"></asp:Label>
					<asp:HiddenField ID="hfTodayDate" Value="" runat="server" />
				</td>
			</tr>

			<tr class="bgbluegrey">
				<td colspan="4" align="center">
					<asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Details"></asp:Label></td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<asp:Label ID="lblDriverCode" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Code"></asp:Label>
				</td>
				<td align="left" colspan="3">
					<asp:Label ID="lblDriverCodeVal" runat="server" CssClass="bluefnt" Text="Sys. Generated"></asp:Label>
					<asp:HiddenField ID="hPrevDriverCode" runat="server" />
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<b style="color: red;">*</b><asp:Label ID="lblDriverName" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Name"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtDriverName" runat="server" CssClass="input">
					</asp:TextBox>
				</td>
				<td align="left">
					<asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Manual Driver Code"></asp:Label>
				</td>
				<td align="left">
					<asp:UpdatePanel ID="UpdatePanel33" runat="server" UpdateMode="Conditional">
						<ContentTemplate>
							<asp:TextBox ID="txtMDCode" runat="server" CssClass="input" AutoPostBack="true" OnTextChanged="txtMDCode_TextChanged">
							</asp:TextBox>
							<asp:Label ID="lblCheckCode" runat="server" ForeColor="red" Visible="false" />
						</ContentTemplate>
						<Triggers>
							<asp:AsyncPostBackTrigger ControlID="txtMDCode" EventName="TextChanged" />
						</Triggers>
					</asp:UpdatePanel>
				</td>
			</tr>
			<tr style="background-color: white">

				<td align="left">
					<b style="color: red;">*</b><asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="F'Name"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtFather" runat="server" CssClass="input">
					</asp:TextBox>
				</td>
				<%
					string Driver_WO_Vehicle = "N";


					System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(Session["SqlProvider"].ToString().Trim());
					conn.Open();
					string sql = "Select * from WebX_Setup_Process";

					System.Data.SqlClient.SqlCommand sqlcmd1 = new System.Data.SqlClient.SqlCommand(sql, conn);
					System.Data.SqlClient.SqlDataReader r1 = sqlcmd1.ExecuteReader();
					if (r1.Read())
					{
						if (r1["Driver_WO_Vehicle"] != null)
						{
							Driver_WO_Vehicle = r1["Driver_WO_Vehicle"].ToString().Trim();
						}
					}
					r1.Close();
				%>

				<td align="left">
					<b style="color: red;">*</b>
					<asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Vehicle Number"></asp:Label>
					<%if (Driver_WO_Vehicle == "N")
						{
					%>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtVehicleNo"
						ErrorMessage="*"></asp:RequiredFieldValidator>
					<%}
					%>  
				</td>
				<td align="left">
					<asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
						<ContentTemplate>
							<asp:TextBox ID="txtVehicleNo" runat="server" CssClass="input" AutoPostBack="true" OnTextChanged="txtVehicleNo_TextChanged"
								onblur="javascript:test()">
							</asp:TextBox>&nbsp;&nbsp;    
                            <asp:Label ID="lblPopup" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(2)">...</a>'
								Width="14px"></asp:Label>
							<a runat="server" id="VehicleHistoryReport" onclick="VehicleHistory()">History</a>
							<asp:Label ID="lblCheck" runat="server" ForeColor="red" Visible="false" />
						</ContentTemplate>
						<Triggers>
							<asp:AsyncPostBackTrigger ControlID="txtVehicleNo" EventName="TextChanged" />
						</Triggers>
					</asp:UpdatePanel>
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<asp:Label ID="lblLocation" runat="server" CssClass="blackfnt " Font-Bold="true" Text="Location"></asp:Label>

				</td>
				<td align="left">
					<asp:DropDownList ID="ddlLocation" runat="server" CssClass="input" onChange="javascript: return storeValueInHidden(this.id,'hdfLocation')">
					</asp:DropDownList>
					<asp:HiddenField ID="hdfLocation" runat="server" />
				</td>
				<td align="left">
					<b style="color: red;">*</b>
					<asp:Label ID="lblContactNo" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Mobile No."></asp:Label>

				</td>
				<td align="left">
					<asp:TextBox ID="txtContact" MaxLength="10" runat="server" CssClass="input" onkeypress="javascript:return validInt(event,this.getAttribute('id'))">
					</asp:TextBox>
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left" rowspan="2">
					<asp:Label ID="lblCAddress" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Current Address"></asp:Label>
				</td>
				<td align="left" rowspan="2">
					<asp:TextBox ID="txtCAddress" runat="server" CssClass="input" TextMode="MultiLine" Width="250px" Height="50px">
					</asp:TextBox>
				</td>
				<td align="left">
					<asp:Label ID="lblDOB" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Date Of Birth"></asp:Label>
				</td>
				<td align="left">
					<DateP:DTP runat="server" ID="txtDOB" AllowFutureDate="false" AllowPastDate="true" />
				</td>
			</tr>
			<tr style="background-color: white">

				<td align="left">
					<b style="color: red">*</b>
					<asp:Label ID="lvlValDt" runat="server" CssClass="blackfnt" Font-Bold="true" Text="D/L Validity"></asp:Label>
				</td>
				<td align="left">
					<DateP:DTP runat="server" ID="txtValDt" AllowFutureDate="true" AllowPastDate="true" />
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<asp:Label ID="lblLicNum" runat="server" CssClass="blackfnt" Font-Bold="true" Text="D/L No."></asp:Label>
				</td>
				<td align="left">
					<asp:UpdatePanel ID="UPLicNo" runat="server" UpdateMode="Conditional">
						<ContentTemplate>
							<asp:TextBox ID="txtLicNo" runat="server" MaxLength="50" CssClass="input" AutoPostBack="true" OnTextChanged="txtLicNo_TextChanged">
							</asp:TextBox>
							<asp:Label ID="lblLicNo" runat="server" ForeColor="red" Visible="false" />
						</ContentTemplate>
						<Triggers>
							<asp:AsyncPostBackTrigger ControlID="txtLicNo" EventName="TextChanged" />
						</Triggers>
					</asp:UpdatePanel>
					<%--<asp:TextBox ID="txtLicNo" runat="server" CssClass="input" Width="250">
                    </asp:TextBox>--%>
				</td>
				<td align="left">
					<asp:Label ID="lblbIssueDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Renewal Date"></asp:Label>
				</td>
				<td align="left">
					<DateP:DTP runat="server" ID="txtissueDate" AllowFutureDate="false" AllowPastDate="True" />
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<b style="color: red;">*</b>
					<asp:Label ID="lblIssued" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Issued By RTO"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtRTO" runat="server" CssClass="input" Width="250" TextMode="SingleLine"></asp:TextBox>
				</td>
				<td align="left">
					<asp:Label ID="lblFlag" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Status"></asp:Label>
				</td>
				<td align="left">

					<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
						<ContentTemplate>
							<asp:DropDownList ID="cboStatus" runat="server"
								AutoPostBack="true" OnSelectedIndexChanged="cboStatus_SelectedIndexChanged">
								<asp:ListItem Text="Active" Value="Y"></asp:ListItem>
								<asp:ListItem Text="Inactive" Value="N"></asp:ListItem>
							</asp:DropDownList>
							<asp:Label ID="lblStatus" runat="server" ForeColor="red" Visible="false" />
							<asp:HiddenField ID="hdfStatus" runat="server" />
						</ContentTemplate>
						<Triggers>
							<asp:AsyncPostBackTrigger ControlID="cboStatus" EventName="SelectedIndexChanged" />
						</Triggers>
					</asp:UpdatePanel>
				</td>
			</tr>
			<tr style="background-color: white">

				<td align="left">
					<asp:Label ID="lblLicIssueDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="License Issue Date:"></asp:Label>

				</td>
				<td align="left">
					<DateP:DTP runat="server" ID="txtLicIssueDate" AllowFutureDate="false" AllowPastDate="True" />
				</td>
				<td>
					<asp:Label ID="lblLicCategory" runat="server" CssClass="blackfnt" Font-Bold="true" Text="License Category"></asp:Label>
				</td>
				<td>
					<asp:DropDownList ID="ddlLicCategory" runat="server" CssClass="blackfnt">
						<asp:ListItem Value="0">---Select---</asp:ListItem>
						<asp:ListItem Value="1">NT</asp:ListItem>
						<asp:ListItem Value="2">TRANS</asp:ListItem>
						<asp:ListItem Value="3">NON TRANS</asp:ListItem>
						<asp:ListItem Value="4">HMV</asp:ListItem>
						<asp:ListItem Value="5">MCWG</asp:ListItem>
						<asp:ListItem Value="6">PSVBUS</asp:ListItem>
					</asp:DropDownList>
				</td>
			</tr>
			<tr style="background-color: white">
				<td>
					<asp:Label ID="lblAddressVerfiedBy" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Address verified by"></asp:Label>
				</td>
				<td>
					<asp:TextBox ID="txtAddressVerfiedBy" runat="server" CssClass="input">
					</asp:TextBox>
				</td>
				<td>
					<asp:Label ID="lblAddressVerfiedDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Address verified Date"></asp:Label>
				</td>
				<td>
					<DateP:DTP runat="server" ID="txtAddressVerfiedDate" AllowFutureDate="false" AllowPastDate="True" />
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<asp:Label ID="Label12" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Village"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtVillageName" runat="server" CssClass="input"></asp:TextBox>
				</td>
				<td align="left">
					<asp:Label ID="Label16" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Tahseel"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtTahseel" runat="server" CssClass="input" TextMode="SingleLine"></asp:TextBox>
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<asp:Label ID="lblPS" runat="server" CssClass="blackfnt" Font-Bold="true" Text="P.S"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtPS" runat="server" CssClass="input"></asp:TextBox>
				</td>
				<td align="left">
					<asp:Label ID="lblPO" runat="server" CssClass="blackfnt" Font-Bold="true" Text="P.O"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtPO" runat="server" CssClass="input" TextMode="SingleLine"></asp:TextBox>
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<asp:Label ID="lblDist" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Dist."></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtDist" runat="server" CssClass="input"></asp:TextBox>
				</td>
				<td align="left">
					<asp:Label ID="lblState" runat="server" CssClass="blackfnt" Font-Bold="true" Text="State"></asp:Label>
				</td>
				<td align="left">

					<asp:DropDownList ID="ddlstate" runat="server" CssClass="blackfnt" onChange="javascript: return storeValueInHidden(this.id,'hdfState')"></asp:DropDownList>
					<asp:HiddenField ID="hdfState" runat="server" />
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<b style="color: red;">*</b>
					<asp:Label ID="Label15" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Mobile No.(Village)"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtVillageMobileNo" runat="server" CssClass="input" MaxLength="10" onkeypress="javascript:return validInt(event,this.getAttribute('id'))"></asp:TextBox>
				</td>
				<td align="left">
					<asp:Label ID="Label17" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Alternative Number"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtAlternativeMobileNo" runat="server" CssClass="input" MaxLength="10" onkeypress="javascript:return validInt(event,this.getAttribute('id'))"></asp:TextBox>
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<b style="color: red">*</b>
					<asp:Label ID="lblReferenceName" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Reference Name"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtReferenceName" runat="server" CssClass="input" MaxLength="100"></asp:TextBox>
				</td>
				<td align="left">
					<b style="color: red">*</b>
					<asp:Label ID="lblReferenceMobileNo" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Reference Mobile No."></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtReferenceMobileNo" runat="server" CssClass="input" MaxLength="10" onkeypress="javascript:return validInt(event,this.getAttribute('id'))"></asp:TextBox>
				</td>
			</tr>
			<tr class="bgbluegrey">
				<td align="center" colspan="4">
					<asp:Label ID="Label13" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Address Proof"></asp:Label>
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<b style="color: red">*</b>
					<asp:Label ID="Label19" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Aadhar Card No"></asp:Label>
				</td>
				<td align="left">

					<asp:UpdatePanel ID="UPAadharCardNo" runat="server" UpdateMode="Conditional">
						<ContentTemplate>
							<asp:TextBox ID="txtAadharCardNo" runat="server" MaxLength="12" CssClass="input" AutoPostBack="true" OnTextChanged="txtAadharCardNo_TextChanged">
							</asp:TextBox>
							<asp:Label ID="lblAdharCard" runat="server" ForeColor="red" Visible="false" />
						</ContentTemplate>
						<Triggers>
							<asp:AsyncPostBackTrigger ControlID="txtAadharCardNo" EventName="TextChanged" />
						</Triggers>
					</asp:UpdatePanel>
					<%--<asp:TextBox ID="txtAadharCardNo" runat="server" MaxLength="16" CssClass="input" AutoPostBack="true" OnTextChanged="txtAadharCardNo_TextChanged"></asp:TextBox>
                    <asp:Label ID="lblAdharCard" runat="server" ForeColor="red" Visible="false" />--%>
					<asp:FileUpload ID="fileAadharCardNo" runat="server" />
					<a href="javascript:popupMe('LblAadharCardNo')">
						<asp:Label ID="LblAadharCardNo" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
				</td>
				<td align="left">
					<asp:Label ID="Label6" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Election Card No"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtElectionCardNo" runat="server" MaxLength="20" CssClass="input"></asp:TextBox>
					<asp:FileUpload ID="FileElectionCardNo" runat="server" />
					<a href="javascript:popupMe('lblElectionCardNo')">
						<asp:Label ID="lblElectionCardNo" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">

					<asp:Label ID="Label9" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Ration Card No"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtRationCardNo" runat="server" MaxLength="16" CssClass="input"></asp:TextBox>
					<asp:FileUpload ID="FileRationCardNo" runat="server" />
					<a href="javascript:popupMe('lblRationCardNo')">
						<asp:Label ID="lblRationCardNo" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
				</td>
				<td align="left">

					<asp:Label ID="Label11" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Passport No"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtPassportNo" runat="server" MaxLength="20" CssClass="input"></asp:TextBox>
					<asp:FileUpload ID="FilePassportNo" runat="server" />
					<a href="javascript:popupMe('lblPassportNo')">
						<asp:Label ID="lblPassportNo" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">

					<asp:Label ID="Label10" runat="server" CssClass="blackfnt" Font-Bold="true" Text="PAN Card No"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtPANCardNo" runat="server" MaxLength="16" CssClass="input"></asp:TextBox>
					<asp:FileUpload ID="FilePANCardNo" runat="server" />
					<a href="javascript:popupMe('lblPANCardNo')">
						<asp:Label ID="lblPANCardNo" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
				</td>
				<td align="left">

					<asp:Label ID="Label18" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Bank Account Statement"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtBankAccountStatement" runat="server" MaxLength="20" CssClass="input"></asp:TextBox>
					<asp:FileUpload ID="FileBankAccountStatement" runat="server" />
					<a href="javascript:popupMe('lblBankAccountStatement')">
						<asp:Label ID="lblBankAccountStatement" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">
					<b style="color: red">*</b>
					<asp:Label ID="Label14" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Photo"></asp:Label>
				</td>
				<td align="left">

					<asp:FileUpload ID="FilePhoto" runat="server" />
					<a href="javascript:popupMe('lblPhoto')">
						<asp:Label ID="lblPhoto" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
				</td>
				<td align="left">
					<b style="color: red">*</b>
					<asp:Label ID="Label21" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Bio Data"></asp:Label>
				</td>
				<td align="left">

					<asp:FileUpload ID="FileDriverBioData" runat="server" />
					<a href="javascript:popupMe('lblDriverBioData')">
						<asp:Label ID="lblDriverBioData" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
				</td>
			</tr>
			<tr style="background-color: white">
				<td align="left">

					<asp:Label ID="lblDriverLicVerfiedBy" runat="server" CssClass="blackfnt" Font-Bold="true" Text="D/L Verified by"></asp:Label>
				</td>
				<td align="left">
					<asp:TextBox ID="txtDriverLicVerfiedBy" runat="server" CssClass="input"></asp:TextBox>

				</td>
				<td align="left">

					<asp:Label ID="lblDLVerifiedDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="D/L Verified date"></asp:Label>
				</td>
				<td align="left">
					<DateP:DTP runat="server" ID="txtDLVerifiedDate" AllowFutureDate="false" AllowPastDate="true" />
					<asp:FileUpload ID="FileDLVerifiedDate" runat="server" />
					<a href="javascript:popupMe('lbl_DLVerifiedDate')">
						<asp:Label ID="lbl_DLVerifiedDate" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
				</td>
			</tr>

			<tr style="background-color: white">
				<td align="left">
					<b style="color: red">*</b>
					<asp:Label ID="lblAgreement" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Agreement Copy Upload"></asp:Label>
				</td>
				<td align="left">
					<asp:FileUpload ID="FileAgreementCopyUpload" runat="server" />
					<a href="javascript:popupMe('lblAgreementCopyUpload')">
						<asp:Label ID="lblAgreementCopyUpload" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label>
					</a>
				</td>
				<td align="left" colspan="2"></td>
			</tr>

			<tr style="background-color: white">
				<td colspan="4" align="right">
					<asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="cmdSubmit_Click" OnClientClick="javascript:return CHECKVALID()" />&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>
</asp:Content>

