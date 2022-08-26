<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AddCustLocwithDiffAddressEdit.aspx.cs" Inherits="GUI_admin_CustomerMaster_AddCustLocwithDiffAddressEdit" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript"> 
     function nwOpen(mNo)
        {
            window.open("popupLoc.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }

    </script>
    <div>
 <asp:UpdatePanel ID="upTable" runat="server">
   	<ContentTemplate> 

    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 640px">
		<tr> 
			<td>&nbsp;</td>
		</tr>

		<tr> 
			<td> 
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
					<tr> 
						<td height="30">
							<a href=""><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Business Partners</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Customer Master</b></font>
						</td>
					</tr>
				        
					<tr> 
						<td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
					</tr>
					
					<tr> 
						<td style="height: 1px"></td>
					</tr>

					<tr> 
						<td align="center">
							<%--<a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>--%>
                            <asp:Label ID="Label1" runat="server" ForeColor="#FF8080"></asp:Label></td>
					</tr>

					<tr> 
						<td>
						<br /><br />
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td width="39%" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td valign="top" style="height: 442px">
											
											<table align="center" border="0" cellpadding="0" cellspacing="1" width="100%" class="boxbg">
                                                <tr class="bgbluegrey">
                                                    <td colspan="3" align="center"><font class="blackfnt"><b>ADD CUSTOMER LOCATIONS WITH SINGLE BUT DIFFERENT ADDRESS</b></font></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF">
                                                    <table  border="0" cellspacing="0" cellpadding="3"	width="100%" >
                                                    <tr>
                                                    <td><font class="blackfnt">Group Code</font></td>
                                                    <td><font class="blackfnt">:</font></td>
                                                    <td><font class="blackfnt">
                                                        <asp:Label ID="lblGrpCd" runat="server"></asp:Label></font></td>
                                                    <td><font class="blackfnt">&nbsp;</font></td>
                                                    <td><font class="blackfnt">&nbsp;</font></td>
                                                    <td></td>
                                                    </tr>

                                                    <tr>
                                                    <td valign="top"><font class="blackfnt">Customer Code</font></td>
                                                    <td><font class="blackfnt">:</font></td>
                                                    <td><font class="blackfnt" color="red">
                                                        <asp:Label ID="lblCstCd" runat="server" ForeColor="#FF8080"></asp:Label></td>
                                                    <td><font class="blackfnt">Customer Name</font></td>
                                                    <td><font class="blackfnt">:<asp:Label ID="lblCstNm" runat="server"></asp:Label></font></td>
                                                    <td><font class="blackfnt" color="red"></font></td>
                                                    </tr>

                                                </table>
                                                       </td>
                                                </tr>
                                                </table>
											
											<!--START-->
												<br/>
												<center>
												<table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="100%" style="height: 471px">
                                                        <tr class="bgbluegrey" style="height: 61px">
                                                        <td style="width: 16px; height: 61px" align="center"><font class="blackfnt">&nbsp;<b>Select</b></font></td>
                                                        <td style="width: 43px; height: 61px" align="center" valign="middle"><font class="blackfnt"><b>&nbsp;Location Code</b>&nbsp;</td>
                                                        <td style="width: 124px; height: 61px"><font class="blackfnt"><b>Address</b></font></td>
                                                        <td style="width: 120px; height: 61px"><font class="blackfnt"><b>City</b></font>
                                                        </td>
                                                        <td style="height: 61px; width: 42px;" valign="middle"><font class="blackfnt"><b>Pincode</b></font></td>
                                                        <td style="height: 61px; width: 37px;"><font class="blackfnt"><b>ContactPerson</b></font></td>
                                                        <td style="height: 61px"><font class="blackfnt"><b>Tel.</b></font></td>
                                                        <td style="height: 61px"><font class="blackfnt"><b>Fax</b></font></td>
                                                        <td style="height: 61px"><font class="blackfnt"><b>Email</b></font>
                                                        </td>
                                                        <td style="height: 61px; width: 27px;"><font class="blackfnt"><b>&nbsp;Act.<br />
                                                            Flag</b></font></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px; height: 5px;" align="center">
                                                            <asp:CheckBox ID="chk1" runat="server" AutoPostBack="True" /></td>
                                                        <td style="width: 43px; height: 5px;" align="center">
                                                            <asp:TextBox ID="txtLocCod1" runat="server" Width="74px"></asp:TextBox>
                                                            <asp:Label ID="lblLocCod1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px; height: 5px;">
                                                            <asp:TextBox ID="txtAdd1" runat="server" Height="40px" TextMode="MultiLine" Width="166px"></asp:TextBox></td>
                                                        <td style="width: 120px; height: 5px;">
                                                            <asp:TextBox ID="txtCity1" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="height: 5px; width: 42px;">
                                                            <asp:TextBox ID="txtPinCod1" runat="server" Width="74px"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 37px; height: 5px;">
                                                            <asp:TextBox ID="txtContPer1" runat="server" Width="101px"></asp:TextBox>
                                                        </td>
                                                        <td style="height: 5px">
                                                            <asp:TextBox ID="txtTel1" runat="server" Width="72px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 5px">
                                                            <asp:TextBox ID="txtFax1" runat="server" Width="68px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 5px">
                                                            <asp:TextBox ID="txtEmail1" runat="server" Width="67px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 27px; height: 5px" align="left">
                                                            <asp:CheckBox ID="chk11" runat="server" OnCheckedChanged="chk11_CheckedChanged" AutoPostBack="True" />
                                                            <asp:TextBox ID="txtActFlag1" runat="server" Width="22px" ReadOnly="True">N</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px" align="center">
                                                            <asp:CheckBox ID="chk2" runat="server" /></td>
                                                        <td style="width: 43px" align="center">
                                                            <asp:TextBox ID="txtLocCod2" runat="server" Width="74px"></asp:TextBox>
                                                            <asp:Label ID="lblLocCod2" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(2)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtAdd2" runat="server" Height="39px" TextMode="MultiLine" Width="166px"></asp:TextBox></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtCity2" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtPinCod2" runat="server" Width="74px"></asp:TextBox></td>
                                                        <td style="width: 37px">
                                                            <asp:TextBox ID="txtContPer2" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtTel2" runat="server" Width="72px"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtFax2" runat="server" Width="68px"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmail2" runat="server" Width="67px"></asp:TextBox>&nbsp;</td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk12" runat="server" AutoPostBack="True" OnCheckedChanged="chk12_CheckedChanged" />
                                                            <asp:TextBox ID="txtActFlag2" runat="server" Width="22px" ReadOnly="True">N</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px" align="center">
                                                            <asp:CheckBox ID="chk3" runat="server" /></td>
                                                        <td style="width: 43px" align="center">
                                                            <asp:TextBox ID="txtLocCod3" runat="server" Width="74px"></asp:TextBox>
                                                            <asp:Label ID="lblLocCod3" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(3)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtAdd3" runat="server" Height="38px" TextMode="MultiLine" Width="166px"></asp:TextBox></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtCity3" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtPinCod3" runat="server" Width="74px"></asp:TextBox></td>
                                                        <td style="width: 37px">
                                                            <asp:TextBox ID="txtContPer3" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtTel3" runat="server" Width="72px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtFax3" runat="server" Width="68px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmail3" runat="server" Width="67px"></asp:TextBox>&nbsp;</td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk13" runat="server" AutoPostBack="True" OnCheckedChanged="chk13_CheckedChanged" />
                                                            <asp:TextBox ID="txtActFlag3" runat="server" Width="23px" ReadOnly="True">N</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px" align="center">
                                                            <asp:CheckBox ID="chk4" runat="server" /></td>
                                                        <td style="width: 43px" align="center">
                                                            <asp:TextBox ID="txtLocCod4" runat="server" Width="74px"></asp:TextBox>
                                                            <asp:Label ID="lblLocCod4" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(4)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtAdd4" runat="server" Height="37px" TextMode="MultiLine" Width="166px"></asp:TextBox></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtCity4" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtPinCod4" runat="server" Width="74px"></asp:TextBox></td>
                                                        <td style="width: 37px">
                                                            <asp:TextBox ID="txtContPer4" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtTel4" runat="server" Width="72px"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtFax4" runat="server" Width="68px"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmail4" runat="server" Width="67px"></asp:TextBox></td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk14" runat="server" AutoPostBack="True" OnCheckedChanged="chk14_CheckedChanged" />
                                                            <asp:TextBox ID="txtActFlag4" runat="server" Width="22px" ReadOnly="True">N</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px" align="center">
                                                            <asp:CheckBox ID="chk5" runat="server" /></td>
                                                        <td style="width: 43px" align="center">
                                                            <asp:TextBox ID="txtLocCod5" runat="server" Width="74px"></asp:TextBox>
                                                            <asp:Label ID="lblLocCod5" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(5)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtAdd5" runat="server" Height="38px" TextMode="MultiLine" Width="166px"></asp:TextBox></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtCity5" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtPinCod5" runat="server" Width="74px"></asp:TextBox></td>
                                                        <td style="width: 37px">
                                                            <asp:TextBox ID="txtContPer5" runat="server" Width="101px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtTel5" runat="server" Width="72px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtFax5" runat="server" Width="68px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmail5" runat="server" Width="67px"></asp:TextBox>&nbsp;</td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk15" runat="server" AutoPostBack="True" OnCheckedChanged="chk15_CheckedChanged" />
                                                            <asp:TextBox ID="txtActFlag5" runat="server" Width="22px" ReadOnly="True">N</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px" align="center">
                                                            <asp:CheckBox ID="chk6" runat="server" /></td>
                                                        <td style="width: 43px" align="center">
                                                            <asp:TextBox ID="txtLocCod6" runat="server" Width="74px"></asp:TextBox>
                                                            <asp:Label ID="lblLocCod6" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(6)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtAdd6" runat="server" Height="38px" TextMode="MultiLine" Width="166px"></asp:TextBox></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtCity6" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtPinCod6" runat="server" Width="74px"></asp:TextBox></td>
                                                        <td style="width: 37px">
                                                            <asp:TextBox ID="txtContPer6" runat="server" Width="101px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtTel6" runat="server" Width="72px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtFax6" runat="server" Width="68px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmail6" runat="server" Width="67px"></asp:TextBox>&nbsp;</td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk16" runat="server" AutoPostBack="True" OnCheckedChanged="chk16_CheckedChanged" />
                                                            <asp:TextBox ID="txtActFlag6" runat="server" Width="22px" ReadOnly="True">N</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px" align="center">
                                                            <asp:CheckBox ID="chk7" runat="server" /></td>
                                                        <td style="width: 43px" align="center">
                                                            <asp:TextBox ID="txtLocCod7" runat="server" Width="74px"></asp:TextBox>
                                                            <asp:Label ID="lblLocCod7" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(7)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtAdd7" runat="server" Height="38px" TextMode="MultiLine" Width="166px"></asp:TextBox></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtCity7" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtPinCod7" runat="server" Width="74px"></asp:TextBox>&nbsp;</td>
                                                        <td style="width: 37px">
                                                            <asp:TextBox ID="txtContPer7" runat="server" Width="101px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtTel7" runat="server" Width="72px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtFax7" runat="server" Width="68px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmail7" runat="server" Width="67px"></asp:TextBox></td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk17" runat="server" AutoPostBack="True" OnCheckedChanged="chk17_CheckedChanged" />
                                                            <asp:TextBox ID="txtActFlag7" runat="server" Width="22px" ReadOnly="True">N</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px" align="center">
                                                            <asp:CheckBox ID="chk8" runat="server" /></td>
                                                        <td style="width: 43px" align="center">
                                                            <asp:TextBox ID="txtLocCod8" runat="server" Width="74px"></asp:TextBox>
                                                            <asp:Label ID="lblLocCod8" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(8)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtAdd8" runat="server" Height="39px" TextMode="MultiLine" Width="166px"></asp:TextBox></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtCity8" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtPinCod8" runat="server" Width="74px"></asp:TextBox>&nbsp;</td>
                                                        <td style="width: 37px">
                                                            <asp:TextBox ID="txtContPer8" runat="server" Width="101px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtTel8" runat="server" Width="72px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtFax8" runat="server" Width="68px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmail8" runat="server" Width="67px"></asp:TextBox>&nbsp;</td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk18" runat="server" AutoPostBack="True" OnCheckedChanged="chk18_CheckedChanged" />
                                                            <asp:TextBox ID="txtActFlag8" runat="server" Width="22px" ReadOnly="True">N</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px" align="center">
                                                            <asp:CheckBox ID="chk9" runat="server" /></td>
                                                        <td style="width: 43px" align="center">
                                                            <asp:TextBox ID="txtLocCod9" runat="server" Width="74px"></asp:TextBox>
                                                            <asp:Label ID="lblLocCod9" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(9)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtAdd9" runat="server" Height="40px" TextMode="MultiLine" Width="166px"></asp:TextBox></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtCity9" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtPinCod9" runat="server" Width="74px"></asp:TextBox>&nbsp;</td>
                                                        <td style="width: 37px">
                                                            <asp:TextBox ID="txtContPer9" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtTel9" runat="server" Width="72px"></asp:TextBox>&nbsp;</td>
                                                        <td>
                                                            <asp:TextBox ID="txtFax9" runat="server" Width="68px"></asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtEmail9" runat="server" Width="67px"></asp:TextBox>&nbsp;</td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk19" runat="server" AutoPostBack="True" OnCheckedChanged="chk19_CheckedChanged" />
                                                            <asp:TextBox ID="txtActFlag9" runat="server" Width="22px" ReadOnly="True">N</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px; height: 15px;" align="center">
                                                            <asp:CheckBox ID="chk10" runat="server" /></td>
                                                        <td style="width: 43px; height: 15px;" align="center">
                                                            <asp:TextBox ID="txtLocCod10" runat="server" Width="74px"></asp:TextBox>
                                                            <asp:Label ID="lblLocCod10" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(10)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px; height: 15px;">
                                                            <asp:TextBox ID="txtAdd10" runat="server" Height="39px" TextMode="MultiLine" Width="166px"></asp:TextBox></td>
                                                        <td style="width: 120px; height: 15px;">
                                                            <asp:TextBox ID="txtCity10" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="width: 42px; height: 15px">
                                                            <asp:TextBox ID="txtPinCod10" runat="server" Width="74px"></asp:TextBox></td>
                                                        <td style="width: 37px; height: 15px;">
                                                            <asp:TextBox ID="txtContPer10" runat="server" Width="101px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtTel10" runat="server" Width="72px"></asp:TextBox>&nbsp;</td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtFax10" runat="server" Width="68px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtEmail10" runat="server" Width="67px"></asp:TextBox></td>
                                                        <td style="width: 27px; height: 15px;" align="left"><asp:CheckBox ID="chk20" runat="server" AutoPostBack="True" OnCheckedChanged="chk20_CheckedChanged" /><asp:TextBox ID="txtActFlag10" runat="server" Width="21px" ReadOnly="True">N</asp:TextBox></td>
                                                        </tr>
                                                        </table>
                                                </center>
											<!--END-->
											</td>
										</tr>
										    
										<tr> 
					                          <td align="center">&nbsp;
					                            <%--<asp:Button ID="btnAddCity" runat="server" Text="Submit" OnClick="btnAddCity_Click" />&nbsp;
					                            <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
                                                <asp:Label ID="lblmsg" runat="server" ForeColor="#FF8080"></asp:Label>--%>
                                              </td>
										</tr>
										
										<%--<tr>
											<td align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr> 
													<td colspan="10" align="center" style="height: 6px">
														<div id="ProcessIndiacatorSubmit" style="HEIGHT: 71px; LEFT: 14px; POSITION: absolute; VISIBILITY: visible; WIDTH: 100%; Z-INDEX: 12; top: 0px;">
														   <p align="center"></p>
														</div>

														<div id="ProcessIndiacator" style="HEIGHT: 71px; LEFT: 14px; POSITION: absolute; VISIBILITY: hidden; WIDTH: 100%; Z-INDEX: 12; top: 0px;">
														</div>														
													</td>
												</tr>
												</table>
                                                </td>
										</tr>
											<tr valign="top">
												<td ><font color="red"><font class="blackfnt"><b></b></font></font></td>
											</tr>
									    <tr>
											<td></td>
										</tr>--%>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
			</table>
	</td>
	</tr>
	</table>
	</ContentTemplate>
	</asp:UpdatePanel>
	<%--<asp:UpdatePanel ID="upBtn" runat="server">
   	    <ContentTemplate>--%>
	        <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
	        <tr>
	        <td align="center">
	        <asp:Button ID="btnAddCity" runat="server" Text="Submit" OnClick="btnAddCity_Click" />&nbsp;
	        <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
            <asp:Label ID="lblmsg" runat="server" ForeColor="#FF8080"></asp:Label>
            </td>
            </tr>
            </table>
        <%--</ContentTemplate>
	</asp:UpdatePanel>--%>
	    
    </div>
</asp:Content>

