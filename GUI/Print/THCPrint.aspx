<%@ Page Language="C#" AutoEventWireup="true" CodeFile="THCPrint.aspx.cs" Inherits="GUI_Print_THCPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>THC View</title>
    <link href="../images/style.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
<object id="objPrint" classid="CLSID:91DF5E28-29FB-4D68-A027-60F581A55443"     codebase="http://202.87.45.77/webx/dosprint/print_utility/ecfy_dos_print.cab#version=1,0,0,0"></object>

    <form id="form1" runat="server">
        <div align="center">
            <table border="1" style="width: 9.0in" cellpadding="2" cellspacing="1">
                <tr bgcolor="#FFFFFF">
                    <td width="561" align="left">
                        <asp:Image ID="imgLogo" runat="server" ImageAlign="TextTop" Height="50px" Width="140px"/></td>
                    <td width="433" valign="top">
                        <table border="0" cellpadding="2" cellspacing="1" style="width: 5.0in" class="boxbg">
                            <tr bgcolor="#FFFFFF">
                                <td align="left">
                                    <font class="blackfnt"><%=Session["THCCalledAs"].ToString()%> Number: </font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="LblTHCNo" CssClass="bluefnt" runat="server"></asp:Label>
                                    </font>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td align="left">
                                    <font class="blackfnt">Manual <%=Session["THCCalledAs"].ToString()%> No: </font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="LblMTHCNo" CssClass="bluefnt" runat="server"></asp:Label>
                                    </font>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td align="left">
                                    <font class="blackfnt"><%=Session["THCCalledAs"].ToString()%> Date: </font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="LblTHCDt" CssClass="bluefnt" runat="server"></asp:Label>
                                    </font>
                                </td>
                            </tr>
                            <%--<tr bgcolor="#FFFFFF">
                                <td align="left">
                                    <font class="blackfnt">THC Updated On:
                                    </font>
                                </td>
                                 <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="LblTHCUpdateOn" CssClass="bluefnt" runat="server" ></asp:Label>
                                    </font>
                                </td>
                            </tr>--%>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 9.0in" border="0" cellspacing="1" cellpadding="2" class="boxbg">
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Route</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="LblRoute" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Current Location</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="LblCurLoc" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="16%" align="left">
                        <font class="blackfnt">Vendor Name</font></td>
                    <td width="21%" align="left">
                        <asp:Label ID="LblVendorName" CssClass="bluefnt" runat="server" Width="188px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt"><%=Session["THCCalledAs"].ToString()%> Mode</font></td>
                    <td align="left">
                        <asp:Label ID="lblTHCMode" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">Next Stop</font></td>
                    <td align="left">
                        <asp:Label ID="LblNxtStop" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">Vendor Type</font></td>
                    <td align="left">
                        <asp:Label ID="LblVendorType" CssClass="bluefnt" runat="server" Text="Label" Width="184px"></asp:Label></td>
                </tr>
                <%--<tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Out Vehicle Free Space</font></td>
                    <td align="left">
                        <asp:Label ID="lblOnVehicleFree" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">Seal No</font></td>
                    <td align="left">
                        <asp:Label ID="lblSealNo" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">Phone No</font></td>
                    <td align="left">
                        <asp:Label ID="lblPhoneNo" CssClass="bluefnt" runat="server" Width="184px"></asp:Label></td>
                </tr>--%>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Actual Dep. Date/Time</font></td>
                    <td align="left">
                        <asp:Label ID="lblActualDepDate" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">Schedule Date-Time</font></td>
                    <td align="left">
                        <asp:Label ID="lblScheduleDt" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">Late Departure Reason (if any)</font></td>
                    <td align="left">
                        <asp:Label ID="lblLateDeptReason" CssClass="bluefnt" runat="server" Width="184px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Starting KM</font></td>
                    <td align="left">
                        <asp:Label ID="lblStartKM" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                   <td align="left">
                        <font class="blackfnt">Seal No</font></td>
                    <td align="left">
                        <asp:Label ID="lblSealNo" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="left">
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td colspan="6">
                        <font class="blackfnt">&nbsp;<strong> Vehicle &amp; Driver Summary</strong></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Number</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="LblVehNO" runat="server" Text="l" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Vehicle Type</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="LblVehType" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Fitness Validity Date</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="LblFitValDt" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Registration Date</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="LblRegDate" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Insurance Validity Date</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="LblInsValDt" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Payload Kg.</font>
                    </td>
                    <td align="left">
                        <asp:Label ID="LblCapacity" CssClass="bluefnt" runat="server" Width="142px"></asp:Label>&nbsp;</td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td style="height: 21px" align="left">
                        <font class="blackfnt">Chassis No.</font></td>
                    <td style="height: 21px" align="left">
                        <font class="bluefnt">
                            <asp:Label ID="LblChassisNo" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></td>
                    <td style="height: 21px" align="left">
                        <font class="blackfnt">Engine no.</font></td>
                    <td style="height: 21px" align="left">
                        <font class="bluefnt">
                            <asp:Label ID="LblEngineNo" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></td>
                    <td style="height: 21px" align="left">
                        <font class="blackfnt"></font>
                    </td>
                    <td style="height: 21px" align="left">
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 9.0in" border="0" cellspacing="1" cellpadding="2" class="boxbg">
                <tr class="bgbluegrey" align="center">
                    <td>
                        <div align="center">
                            <font class="blackfnt"><strong>Driver Name</strong></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt"><strong>License No.</strong></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt"><strong>Validity Date</strong></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt"><strong>Issued by RTO</strong></font></div>
                    </td>
                    <%--<td colspan="2" rowspan="3" >&nbsp;</td>--%>
                </tr>
                <tr id="driver1" visible="true" runat="server" bgcolor="#FFFFFF">
                    <td>
                        <div align="center">
                            <font class="bluefnt">&nbsp;
                                <asp:Label ID="Lbldriver1" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="bluefnt">
                                <asp:Label ID="Lbldriver1lic" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="bluefnt">&nbsp;
                                <asp:Label ID="Lbldriver1valdt" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="bluefnt">
                                <asp:Label ID="Lbldriver1RTO" runat="server" CssClass="blackfnt" Width="142px"></asp:Label>&nbsp;
                            </font>
                        </div>
                    </td>
                </tr>
                <tr id="driver2" visible="false" runat="server" bgcolor="#FFFFFF">
                    <td>
                        <div align="center">
                            <font class="bluefnt">&nbsp;
                                <asp:Label ID="Lbldriver2" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="bluefnt">
                                <asp:Label ID="Lbldriver2lic" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font>&nbsp;</div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="bluefnt">&nbsp;
                                <asp:Label ID="Lbldriver2valdt" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="bluefnt">
                                <asp:Label ID="Lbldriver2RTO" runat="server" CssClass="blackfnt" Width="142px"></asp:Label>&nbsp;
                            </font>
                        </div>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 9.0in" border="0" cellspacing="1" cellpadding="2" class="boxbg">
                <tr class="bgbluegrey">
                    <td colspan="6">
                        <font class="blackfnt">&nbsp;<strong>Advance Details</strong></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Standard Contract Amout</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblStandardConAmt" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Contract Amount (+)</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblConAmt" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Telephone Charges</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblTeleCharges" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Hamali(+/-)</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblHamali" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Mamul (-)</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblMamul" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">TDS Rate (%)</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblTDSRate" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">TDS Amount (-)</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblTDSAmt" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Service Tax Rate (%)</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblServiceTaxRate" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Party PAN Number</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblPartyPANNo" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Service Tax (+)</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblServiceTax" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Cess (+)</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblCess" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">TDS Type</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblTDSType" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">TDS Deducated For</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblTDSDedFor" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Advance Amount</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblAdvAmt" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Advance Amount Paid By</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblAdvAmtPaidBy" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt"><b>Balance Amount</b></font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblBalAmt" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt"><b>Balance Payable At</b></font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblBalPayableAt" runat="server" Text="" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                    </td>
                </tr>
            </table>
            <table style="width: 9.0in" border="0" cellspacing="1" cellpadding="2" class="boxbg">
                <tr class="bgbluegrey">
                    <td colspan="9">
                        <div align="center">
                            <font class="blackfnt"><strong>Manifest Summary</strong></font></div>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td colspan="2">
                        <asp:GridView ID="GrdManifest" Style="width: 100%" EmptyDataText="No Records Found....."
                            AllowPaging="false" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                            CssClass="boxbg" CellPadding="2" CellSpacing="1" BorderWidth="0" runat="server"
                            SelectedIndex="1">
                            <Columns>
                                <asp:TemplateField HeaderText="SRNo." ControlStyle-CssClass="blackfnt">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center"/>
                                    <ItemTemplate>
                                        <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-CssClass="blackfnt" HeaderText="Manifest No" DataField="TCNO" ItemStyle-Font-Size="11 px"
                                    ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-CssClass="blackfnt" HeaderText="Manual MF No." DataField="manual_tcno"
                                    ItemStyle-Font-Size="11 px" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-CssClass="blackfnt" HeaderText="From-To" DataField="fromto" ItemStyle-Font-Size="11 px"
                                    ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-CssClass="blackfnt" HeaderText="Date" DataField="tcdt" ItemStyle-Font-Size="11 px"
                                    ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-CssClass="blackfnt" HeaderText="No. of Dockets" DataField="TOT_DKT"
                                    ItemStyle-Font-Size="11 px" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                                    
                                    <asp:TemplateField HeaderText="Package L/B" ControlStyle-CssClass="blackfnt">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center"/>
                                    <ItemTemplate>
                                        <asp:Label ID="lblPkgs11" Text='<%#DataBinder.Eval(Container.DataItem, "TOT_LOAD_PKGS") %>' runat="server"></asp:Label>/<asp:Label ID="lblPkgs1" Text= '<%#DataBinder.Eval(Container.DataItem, "TOT_PKGS") %>' runat="server">
                                        

                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
                                    <asp:TemplateField HeaderText="Weight L/B" ControlStyle-CssClass="blackfnt">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center"/>
                                    <ItemTemplate>
                                     <asp:Label ID="lblWeight11" Text='<%#DataBinder.Eval(Container.DataItem, "TOT_LOAD_ACTWT") %>' runat="server"></asp:Label>/<asp:Label ID="lblWeight111" Text= '<%#DataBinder.Eval(Container.DataItem, "TOT_ACTUWT") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 9.0in" border="0" cellspacing="1" cellpadding="2" class="boxbg">
                <tr class="bgbluegrey" align="center">
                    <td>
                        <div align="center">
                            <font class="blackfnt"><strong>Staff Name</strong></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt"><strong>Sign</strong></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt"><strong>Prepared by</strong></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt"><strong>At</strong></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt"><strong>Entry Date & Time</strong></font></div>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <div align="center">
                            <font class="bluefnt">&nbsp;
                                <asp:Label ID="lblStaffname" runat="server"  CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="bluefnt">
                                <asp:Label ID="lblSign" runat="server"  CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="bluefnt">&nbsp;
                                <asp:Label ID="lblPreparedBy" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="bluefnt">&nbsp;
                                <asp:Label ID="lblAt" runat="server" CssClass="blackfnt"  Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="bluefnt">
                                <asp:Label ID="lblEntryDtandTime" runat="server" CssClass="blackfnt" 
                                    Width="142px"></asp:Label>&nbsp; </font>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script language="javascript" type="text/javascript">
THC_Detail="<%=THC_Detail%>"
alert(THC_Detail)
		<%
		Response.Write(THC_Detail);
		%>
			window.close();
		</script>
</body>
</html>

