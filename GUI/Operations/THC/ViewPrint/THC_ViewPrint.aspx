<%@ Page Language="C#" AutoEventWireup="true" CodeFile="THC_ViewPrint.aspx.cs" Inherits="GUI_Operations_THC_ViewPrint_THC_ViewPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>THC View</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%--<object id="objPrint" classid="CLSID:91DF5E28-29FB-4D68-A027-60F581A55443"     codebase="http://202.87.45.77/webx/dosprint/print_utility/webx_dos_print.cab#version=1,0,0,0"></object>--%>

    <form id="form1" runat="server">
        <div align="center">
            <table border="1" style="width: 9.0in" cellpadding="2" cellspacing="1">
                <tr bgcolor="#FFFFFF">
                    <td align="left" style="width: 561px">
                        <asp:Image ID="imgLogo" runat="server" ImageAlign="TextTop" ImageUrl="~/GUI/images/webxpress_logo.gif" /></td>
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
                          <tr bgcolor="#FFFFFF">
                                <td align="left">
                                    <font class="blackfnt">Vehicle Tracking No:
                                    </font>
                                </td>
                                 <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblVehicleTrackNo" CssClass="bluefnt" runat="server" ></asp:Label>
                                    </font>
                                </td>
                            </tr>
                        </table>
                        
                    </td>
                    
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left" style="width: 561px" colspan="2">
                    <font class="blackfnt"><b>Vehicle Hire Contract</b></font>
                    </td>
                    </tr>
            </table>
            <br />
            
            <table style="width: 9.0in" border="0" cellspacing="1" cellpadding="2" class="boxbg">
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt"><%=Session["THCCalledAs"].ToString()%> Mode</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblTHCMode" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Route</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="LblRoute" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt"></font></td>
                    <td class="blackfnt" width="16%" align="left">
                        </td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Cities covered</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblCities" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Vendor Type</font></td>
                    <td align="left">
                        <asp:Label ID="lblVendorType" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">Vendor</font></td>
                    <td align="left">
                        <asp:Label ID="lblVendor" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    
                </tr>
                
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Vehicle No.</font></td>
                    <td align="left">
                        <asp:Label ID="lblVehicleNo" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">RC Book no</font></td>
                    <td align="left">
                        <asp:Label ID="lblRCBookNo" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Vehicle Type</font></td>
                    <td align="left">
                        <asp:Label ID="lblVehicleType" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                   <td align="left">
                        <font class="blackfnt">Vehicle Reg. date</font></td>
                    <td align="left">
                        <asp:Label ID="lblVehicleRegDt" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Engine No</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblEngineNo" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Insurance Policy Val date</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblInsuranceDt" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Chassis No.</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblChassisNo" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Fitness Cert Val date</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblFitnessDt" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Seal No.</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblSealNo" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Vehicle Free Space</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblVehicleFreeSpace" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Starting Km.</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblStartKM" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Closing Km.</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblClosingKM" CssClass="bluefnt" runat="server" Width="142px"></asp:Label></td>
                    
                </tr>
                
              
            </table>
            
            
            
            <br />
            <table style="width: 9.0in" border="0" cellspacing="1" cellpadding="2" class="boxbg" visible="true">
                <tr id="driverTable" runat="server" class="bgbluegrey" align="center">
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
                    <td colspan="4">
                        <font class="blackfnt">&nbsp;<strong>Advance At:<asp:Label ID="lblAdvAt" CssClass="blackfnt" runat="server" Width="60px"></asp:Label></strong></font></td>
                        <td colspan="2">
                        <font class="blackfnt">&nbsp;<strong>Balance At:<asp:Label ID="lblBalAt" CssClass="blackfnt" runat="server" Width="60px"></asp:Label></strong></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Standard Rate</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblStandardConAmt" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">TDS rate %</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblTDSRate" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Net bal payable</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblNetBalPayable" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Contract Amount</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblConAmt" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">TDS</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblTDS" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Incentive</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblIncentive" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Telephone</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblTelephone" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt"></font></td>
                    <td align="left">
                        <font class="bluefnt">
                            </td>
                    <td align="left">
                        <font class="blackfnt">Deduction</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblDeduction" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Other Amt(+)</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblOther" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Advance Paid</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblAdvancePaid" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">NET balance paid</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                        <asp:Label ID="lblNetBalancePaid" runat="server" Width="142px"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Remarks</font></td>
                    <td align="left">
                        <font class="bluefnt">
                        <asp:Label ID="lblRemarks11" runat="server"></asp:Label>
                            </td>
                    <td align="left">
                        <font class="blackfnt">Payment mode</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblAdvPaymentMode" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Payment mode</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                        <asp:Label ID="lblBalPaymentMode" runat="server" Width="142px"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt"></font></td>
                    <td align="left">
                        <font class="bluefnt">
                            </td>
                    <td align="left">
                        <font class="blackfnt">Voucher no</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblAdvVoucherNo" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Voucher no</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                        <asp:Label ID="lblBalVoucherNo" runat="server" Width="142px"></asp:Label></font>
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
    <%--<script language="javascript" type="text/javascript">
THC_Detail="<%=THC_Detail%>"
alert(THC_Detail)
		<%
		//Response.Write(THC_Detail);
		%>
			//window.close();
		</script>--%>
</body>
</html>
