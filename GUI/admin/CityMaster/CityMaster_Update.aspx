<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CityMaster_Update.aspx.cs" Inherits="CityMaster_Update" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <script language="javascript" type="text/javascript"> 
     function nwOpen(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
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
							<a href=""><font class="blklnkund"><b>Company Structure</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Company Master</b></font>
						</td>
					</tr>
				        
					<tr> 
						<td class="horzblue"><img src="images/clear.gif" width="2" height="1" alt="" /></td>
					</tr>
					
					<tr> 
						<td style="height: 1px"></td>
					</tr>

					<tr> 
						<td align="right">
							<a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
						</td>
					</tr>

					<tr> 
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td width="39%" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td valign="top" style="height: 442px">
											<!--START-->
												<br/>
												<center>
												<table border="0" class="boxbg" cellspacing="1" cellpadding="1" style="width: 780px; height: 471px">
                                                        <tr class="bgbluegrey" style="height: 61px">
                                                        <td style="width: 16px; height: 61px" align="left"> <font class="blackfnt">&nbsp;</font>
                                                        </td>
                                                        <td style="width: 128px; height: 61px"><font class="blackfnt"><b>City Location</b></font>
                                                        </td>
                                                        <td style="width: 124px; height: 61px"><font class="blackfnt"><b>State</b></font>
                                                        </td>
                                                        <td style="width: 120px; height: 61px"><font class="blackfnt"><b>Region</b></font>
                                                        </td>
                                                        <td style="height: 61px; width: 42px;"><font class="blackfnt"><b>Road Bkg. Loc</b></font>
                                                        </td>
                                                        <td style="height: 61px; width: 41px;"><font class="blackfnt"><b>Road Del. Loc</b></font>
                                                        </td>
                                                        <td style="height: 61px"><font class="blackfnt"><b>Air Bkg. Loc</b></font>
                                                        </td>
                                                        <td style="height: 61px"><font class="blackfnt"><b>Air Del. Loc</b></font></td>
                                                        <td style="height: 61px"><font class="blackfnt"><b>Rail Bkg. Loc</b></font>
                                                        </td>
                                                        <td style="height: 61px"><font class="blackfnt"><b>Rail Del. Loc</b></font></td>
                                                        <td style="height: 61px; width: 27px;"><font class="blackfnt"><b>ODA YN<span style="font-size: 12pt; font-family: Times New Roman;
                                                                background-color: #d4e0e7">&nbsp;</span></b></font>
                                                        </td>
                                                        <td style="height: 61px; font-size: 12pt; font-family: Times New Roman;"><font class="blackfnt"><b>ODA Km.</b></font>
                                                        </td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px; height: 9px;">
                                                            <asp:CheckBox ID="chk1" runat="server" AutoPostBack="True" /></td>
                                                        <td style="width: 128px; height: 9px;">
                                                            <asp:TextBox ID="txtCityLoc1" runat="server"></asp:TextBox></td>
                                                        <td style="width: 124px; height: 9px;">
                                                            <asp:DropDownList ID="ddst1" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 120px; height: 9px;">
                                                            <asp:DropDownList ID="ddRg1" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="height: 9px; width: 42px;">
                                                            <asp:TextBox ID="txtRdBkLoc1" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td style="width: 41px; height: 9px;">
                                                            <asp:TextBox ID="txtRdDelLoc1" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label11" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(11)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirBkLoc1" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label21" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(21)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirDlLoc1" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label31" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(31)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtRlBkLoc1" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label41" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(41)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtRlDelLoc1" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label51" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(51)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 27px; height: 9px">
                                                            <asp:CheckBox ID="chk11" runat="server" OnCheckedChanged="chk11_CheckedChanged" AutoPostBack="True" />
                                                            <asp:TextBox ID="txtOda1" runat="server" Width="22px">N</asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtOdaKm1" runat="server" Width="35px" ReadOnly="True">0</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk2" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc2" runat="server"></asp:TextBox></td>
                                                        <td style="width: 124px">
                                                            <asp:DropDownList ID="ddst2" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 120px">
                                                            <asp:DropDownList ID="ddRg2" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRdBkLoc2" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label2" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(2)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRdDelLoc2" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label12" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(12)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirBkLoc2" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label22" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(22)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDlLoc2" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label32" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(32)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlBkLoc2" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label42" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(42)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlDelLoc2" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label52" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(52)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk12" runat="server" AutoPostBack="True" OnCheckedChanged="chk12_CheckedChanged" />
                                                            <asp:TextBox ID="txtOda2" runat="server" Width="22px">N</asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtOdaKm2" runat="server" Width="35px" ReadOnly="True">0</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk3" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc3" runat="server"></asp:TextBox></td>
                                                        <td style="width: 124px">
                                                            <asp:DropDownList ID="ddst3" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 120px">
                                                            <asp:DropDownList ID="ddRg3" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRdBkLoc3" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label3" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(3)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRdDelLoc3" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label13" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(13)">...</a>'
                                                                Width="15px"></asp:Label>&nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirBkLoc3" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label23" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(23)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDlLoc3" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label33" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(33)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlBkLoc3" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label43" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(43)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlDelLoc3" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label53" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(53)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk13" runat="server" AutoPostBack="True" OnCheckedChanged="chk13_CheckedChanged" />
                                                            <asp:TextBox ID="txtOda3" runat="server" Width="23px">N</asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtOdaKm3" runat="server" Width="35px" ReadOnly="True">0</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk4" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc4" runat="server"></asp:TextBox></td>
                                                        <td style="width: 124px">
                                                            <asp:DropDownList ID="ddst4" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 120px">
                                                            <asp:DropDownList ID="ddRg4" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRdBkLoc4" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label4" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(4)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRdDelLoc4" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label14" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(14)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirBkLoc4" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label24" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(24)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDlLoc4" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label34" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(34)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlBkLoc4" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label44" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(44)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlDelLoc4" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label54" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(54)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk14" runat="server" AutoPostBack="True" OnCheckedChanged="chk14_CheckedChanged" />
                                                            <asp:TextBox ID="txtOda4" runat="server" Width="22px">N</asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtOdaKm4" runat="server" Width="35px" ReadOnly="True">0</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk5" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc5" runat="server"></asp:TextBox></td>
                                                        <td style="width: 124px">
                                                            <asp:DropDownList ID="ddst5" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 120px">
                                                            <asp:DropDownList ID="ddRg5" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRdBkLoc5" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label5" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(5)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRdDelLoc5" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label15" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(15)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirBkLoc5" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label25" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(25)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDlLoc5" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label35" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(35)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlBkLoc5" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label45" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(45)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlDelLoc5" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label55" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(55)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk15" runat="server" AutoPostBack="True" OnCheckedChanged="chk15_CheckedChanged" />
                                                            <asp:TextBox ID="txtOda5" runat="server" Width="22px">N</asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtOdaKm5" runat="server" Width="35px" ReadOnly="True">0</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk6" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc6" runat="server"></asp:TextBox></td>
                                                        <td style="width: 124px">
                                                            <asp:DropDownList ID="ddst6" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 120px">
                                                            <asp:DropDownList ID="ddRg6" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRdBkLoc6" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label6" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(6)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRdDelLoc6" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label16" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(16)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirBkLoc6" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label26" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(26)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDlLoc6" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label36" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(36)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlBkLoc6" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label46" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(46)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlDelLoc6" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label56" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(56)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk16" runat="server" AutoPostBack="True" OnCheckedChanged="chk16_CheckedChanged" />
                                                            <asp:TextBox ID="txtOda6" runat="server" Width="22px">N</asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtOdaKm6" runat="server" Width="35px" ReadOnly="True">0</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk7" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc7" runat="server"></asp:TextBox></td>
                                                        <td style="width: 124px">
                                                            <asp:DropDownList ID="ddst7" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 120px">
                                                            <asp:DropDownList ID="ddRg7" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRdBkLoc7" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label7" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(7)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRdDelLoc7" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label17" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(17)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirBkLoc7" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label27" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(27)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDlLoc7" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label37" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(37)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlBkLoc7" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label47" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(47)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlDelLoc7" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label57" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(57)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk17" runat="server" AutoPostBack="True" OnCheckedChanged="chk17_CheckedChanged" />
                                                            <asp:TextBox ID="txtOda7" runat="server" Width="22px">N</asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtOdaKm7" runat="server" Width="35px" ReadOnly="True">0</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk8" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc8" runat="server"></asp:TextBox></td>
                                                        <td style="width: 124px">
                                                            <asp:DropDownList ID="ddst8" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 120px">
                                                            <asp:DropDownList ID="ddRg8" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRdBkLoc8" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label8" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(8)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRdDelLoc8" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label18" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(18)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirBkLoc8" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label28" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(28)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDlLoc8" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label38" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(38)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlBkLoc8" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label48" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(48)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlDelLoc8" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label58" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(58)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk18" runat="server" AutoPostBack="True" OnCheckedChanged="chk18_CheckedChanged" />
                                                            <asp:TextBox ID="txtOda8" runat="server" Width="22px">N</asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtOdaKm8" runat="server" Width="35px" ReadOnly="True">0</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk9" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc9" runat="server"></asp:TextBox></td>
                                                        <td style="width: 124px">
                                                            <asp:DropDownList ID="ddst9" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 120px">
                                                            <asp:DropDownList ID="ddRg9" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRdBkLoc9" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label9" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(9)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRdDelLoc9" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label19" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(19)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirBkLoc9" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label29" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(29)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDlLoc9" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label39" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(39)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlBkLoc9" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label49" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(49)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtRlDelLoc9" runat="server" Width="35px"></asp:TextBox>
                                                            <asp:Label ID="Label59" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(59)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 27px"><asp:CheckBox ID="chk19" runat="server" AutoPostBack="True" OnCheckedChanged="chk19_CheckedChanged" />
                                                            <asp:TextBox ID="txtOda9" runat="server" Width="22px">N</asp:TextBox></td>
                                                        <td>
                                                            <asp:TextBox ID="txtOdaKm9" runat="server" Width="35px" ReadOnly="True">0</asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px; height: 15px;">
                                                            <asp:CheckBox ID="chk10" runat="server" /></td>
                                                        <td style="width: 128px; height: 15px;">
                                                            <asp:TextBox ID="txtCityLoc10" runat="server"></asp:TextBox></td>
                                                        <td style="width: 124px; height: 15px;">
                                                            <asp:DropDownList ID="ddst10" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 120px; height: 15px;">
                                                            <asp:DropDownList ID="ddRg10" runat="server">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 42px; height: 15px">
                                                            <asp:TextBox ID="txtRdBkLoc10" runat="server" Width="31px" ></asp:TextBox>
                                                            <asp:Label ID="Label10" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(10)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 41px; height: 15px;">
                                                            <asp:TextBox ID="txtRdDelLoc10" runat="server" Width="31px"></asp:TextBox>
                                                            <asp:Label ID="Label20" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(20)">...</a>'
                                                                Width="15px"></asp:Label>
                                                        </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtAirBkLoc10" runat="server" Width="31px"></asp:TextBox>
                                                            <asp:Label ID="Label30" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(30)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtAirDlLoc10" runat="server" Width="31px"></asp:TextBox>
                                                            <asp:Label ID="Label40" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(40)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtRlBkLoc10" runat="server" Width="31px"></asp:TextBox>
                                                            <asp:Label ID="Label50" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(50)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtRlDelLoc10" runat="server" Width="31px"></asp:TextBox>
                                                            <asp:Label ID="Label60" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(60)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 27px; height: 15px;" align="left"><asp:CheckBox ID="chk20" runat="server" AutoPostBack="True" OnCheckedChanged="chk20_CheckedChanged" /><asp:TextBox ID="txtOda10" runat="server" Width="21px">N</asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtOdaKm10" runat="server" Width="35px" ReadOnly="True">0</asp:TextBox></td>
                                                        </tr>
                                                        </table>
                                                </center>
											<!--END-->
											</td>
										</tr>
										    
										<tr> 
					                          <td align="center">&nbsp;<asp:Button ID="btnAddCity" runat="server" Text="Submit" OnClick="btnAddCity_Click" />
                                                  &nbsp;
                                              </td>
										</tr>
										
										<tr>
											<td align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr> 
													<td colspan="10" align="center">
														<div id="ProcessIndiacatorSubmit" style="HEIGHT: 71px; LEFT: 14px; POSITION: absolute; VISIBILITY: visible; WIDTH: 100%; Z-INDEX: 12; top: 0px;">
														   <p align="center"></p>
														</div>

														<div id="ProcessIndiacator" style="HEIGHT: 71px; LEFT: 14px; POSITION: absolute; VISIBILITY: hidden; WIDTH: 100%; Z-INDEX: 12; top: 0px;">
														</div>														
													</td>
												</tr>
												</table>
                                                <asp:Label ID="lblMsg" runat="server" ForeColor="#FF8000" Text="Label" Width="244px"></asp:Label></td>
										</tr>
											<tr valign="top">
												<td ><font color="red"><font class="blackfnt"><b><%--No Cities found in the master--%></b></font></font></td>
											</tr>
									    <tr>
											<td></td>
										</tr>
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
	    
    </div>
    </asp:Content>
    
    
