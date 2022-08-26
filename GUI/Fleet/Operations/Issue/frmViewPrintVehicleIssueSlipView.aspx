<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmViewPrintVehicleIssueSlipView.aspx.cs" Inherits="Issue_frmViewPrintVehicleIssueSlipNew" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
              
 

<head runat="server">
    <title>Trip Sheet</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <script type="text/javascript" language="javascript" src="../../../Js/querystring.js" ></script>  
    
    <script language="javascript">


    function printme()
    {
        var qs = new Querystring()
        var mPrintMode=qs.get("PrintMode");
        if(mPrintMode=="1")
        {
            window.print();
        }                      
    }
    </script>

    
</head>

<html>

 
      
      <body onload="printme()" >
    <form id="form1" runat="server">
   
    <table   cellspacing="1" cellpadding="2" width="95%" align="center" class="boxbg" border="0" bgcolor="#8BA0E5">
     
     <tr style="background-color: white">
        <td colspan=4 align=left style="vertical-align: top; text-align: left">
  
    <table id="d" runat="server"  border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                font-family: Verdana">
        <tr>
         <td style="font-weight: bold; width: 20%; height: 48px"  valign="top" align="center" >
                            <asp:Image  Height="50"  ID="img1" ImageUrl="~/GUI/images/Varuna_logoNew.jpg" runat="server" />
                        </td>
            <td align="left" colspan="5" style="font-weight: bold; font-size: 10pt; vertical-align: middle;
                        text-transform: uppercase; font-family: Verdana; width: 80%; height: 48px; text-align: center"
                        valign="top">
                trip sheet</td>
                
        </tr>
    </table>
            
           
            
            <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                font-family: Verdana" id="TABLE2" onclick="return TABLE2_onclick()">
                <tr>
                    <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                        Trip Sheet No:</td>
                    <td align="left" style="width: 17%; height: 16px" valign="top">
                        <asp:Label ID="lblTripsheetNo" runat="server"></asp:Label></td>
                    <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                        Manual Trip Sheet No:</td>
                    <td align="left" style="width: 14%; height: 16px" valign="top">
                        <asp:Label ID="lblManualTripsheet" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                        Trip Start Date &amp; Time:</td>
                    <td align="left" style="width: 17%; height: 16px" valign="top">
                        <asp:Label ID="lblStartDate" runat="server"></asp:Label></td>
                    <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                        Trip End Date &amp; Time:</td>
                    <td align="left" style="width: 14%; height: 16px" valign="top">
                        <asp:Label ID="lblEndDate" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                        Start Location</td>
                    <td align="left" style="width: 17%; height: 16px" valign="top">
                        <asp:Label ID="lblStartLocation" runat="server"></asp:Label></td>
                    <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                        End Location</td>
                    <td align="left" style="width: 14%; height: 16px" valign="top">
                        <asp:Label ID="lblEndLocation" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" style="width: 17%; font-weight: bold; height: 16px;" valign="top">
                        Category</td>
                    <td align="left" style="width: 17%; height: 16px;" valign="top">
                        <asp:Label ID="lblCategory" runat="server"></asp:Label></td>
                    <td align="left" style="width: 15%; font-weight: bold; height: 16px;" valign="top">
                        Customer Code/Name</td>
                    <td align="left" style="width: 14%; height: 16px;" valign="top">
                        <asp:Label ID="lblCustomer" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                        From City</td>
                    <td align="left" style="width: 17%; height: 16px" valign="top">
                        <asp:Label ID="lblFromCity" runat="server"></asp:Label></td>
                    <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                        To City</td>
                    <td align="left" style="width: 14%; height: 16px" valign="top">
                        <asp:Label ID="lblToCity" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                        Route</td>
                    <td align="left" style="width: 17%; height: 16px" valign="top">
                        <asp:Label ID="lblRoute" runat="server"></asp:Label></td>
                    <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                    </td>
                    <td align="left" style="width: 14%; height: 16px" valign="top">
                    </td>
                </tr>
            </table>
            
        <table id="Table3" runat="server"  border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                font-family: Verdana">
            <tr>
                <td align="left" colspan="5" style="font-weight: bold; font-size: 10pt; vertical-align: middle;
                        text-transform: uppercase; font-family: Verdana; height: 31px; text-align: center"
                        valign="top">
                    VEHICLES AND DRIVER&#39;S DETAILS</td>
            </tr>
        </table>
        <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                font-family: Verdana" id="Table1" onclick="return TABLE2_onclick()">
            <tr>
                <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                    Vehicle Number:</td>
                <td align="left" style="width: 17%; height: 16px" valign="top">
                    <asp:Label ID="lblVehno" runat="server"></asp:Label></td>
                <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                </td>
                <td align="left" style="width: 14%; height: 16px" valign="top">
                </td>
            </tr>
            <tr>
                <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                    Driver 1 Name:</td>
                <td align="left" style="width: 17%; height: 16px" valign="top">
                    <asp:Label ID="lblDriver1Name" runat="server"></asp:Label></td>
                <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                    Driver 2 Name:</td>
                <td align="left" style="width: 14%; height: 16px" valign="top">
                    <asp:Label ID="lblDriver2Name" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                    Driver 1 Manual Code:</td>
                <td align="left" style="width: 17%; height: 16px" valign="top">
                    <asp:Label ID="lblDriver1ManualCode" runat="server"></asp:Label></td>
                <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                    Driver 2 Manual Code:</td>
                <td align="left" style="width: 14%; height: 16px" valign="top">
                    <asp:Label ID="lblDriver2ManualCode" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" style="width: 17%; font-weight: bold; height: 16px;" valign="top">
                    Driver 1 Licence Number:</td>
                <td align="left" style="width: 17%; height: 16px;" valign="top">
                    <asp:Label ID="lblDriver1Licence" runat="server"></asp:Label></td>
                <td align="left" style="width: 15%; font-weight: bold; height: 16px;" valign="top">
                    Driver 2 Licence Number:</td>
                <td align="left" style="width: 14%; height: 16px;" valign="top">
                    <asp:Label ID="lblDriver2Licence" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                    Driver 1 Licence Valid Upto:</td>
                <td align="left" style="width: 17%; height: 16px" valign="top">
                    <asp:Label ID="lblDriver1LicValid" runat="server"></asp:Label></td>
                <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                    Driver 2 Licence Valid Upto:</td>
                <td align="left" style="width: 14%; height: 16px" valign="top">
                    <asp:Label ID="lblDriver2LicValid" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                    Starting KM Read:</td>
                <td align="left" style="width: 17%; height: 16px" valign="top">
                    <asp:Label ID="lblStartKm" runat="server"></asp:Label></td>
                <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                </td>
                <td align="left" style="width: 14%; height: 16px" valign="top">
                </td>
            </tr>
            <tr>
                <td align="left" style="font-weight: bold; width: 17%; height: 16px" valign="top">
                                Fuel Filled Ltr.:</td>
                <td align="left" style="width: 17%; height: 16px" valign="top">
                    <asp:Label ID="lblFuel" runat="server"></asp:Label></td>
                <td align="left" style="font-weight: bold; width: 15%; height: 16px" valign="top">
                </td>
                <td align="left" style="width: 14%; height: 16px" valign="top">
                </td>
            </tr>
        </table>
        
         <table id="Table6" runat="server"  border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                font-family: Verdana">
          <tr>
                <td colspan="4" align="left">
                    <asp:Label ID="lblChecklist" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Checklist"></asp:Label></td>
            </tr>
        </table>
            
        <table border="0" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                font-family: Verdana" id="TABLE99">
            <tr style="background-color:White" align="center" >
                <td colspan="4" align="left" bgcolor="white">
                
                     <asp:GridView ID="gvChecklist" runat="server"   
                            AutoGenerateColumns="False" BorderWidth="1px" CellPadding="2"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Font-Size=XX-Small Width="100%">
                              <Columns>
                                <asp:BoundField DataField="Category" HeaderText="Category">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="25%" />
                                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Chk_Desc" HeaderText="Checklist">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="25%"  />
                                    <ItemStyle Width="250px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Checked" HeaderText="Checking Done">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="25%"  />
                                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Chk_Comments" HeaderText="Comments">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="25%"  />
                                    <ItemStyle Width="250px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                              </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            
                        </asp:GridView>
                
                 </td>
            </tr>   
            
              <tr style="background-color: white">
                <td colspan=4 align=left>
                 <table cellspacing="1" cellpadding="2" width="100%" align=left border="1" >
                 
                    <tr style="background-color: white">
                        <td align=center><font class=blackfnt>Checked By</font></td>
                        <td align=center><font class=blackfnt>Checked Date and Time</font></td>
                        <td align=center><font class=blackfnt>Approved By</font></td>
                        <td align=center><font class=blackfnt>Approved Date and Time</font></td>
                    </tr> 
            
                    <tr style="background-color: white">
                        <td align=center><asp:Label ID="lblCheckedByChecklist" runat="server" CssClass="blackfnt"></asp:Label></td>
                        <td align=center><asp:Label ID="lblCheckedDate" runat="server" CssClass="blackfnt"></asp:Label></td>
                        <td align=center><asp:Label ID="lblApprovedByChecklist" runat="server" CssClass="blackfnt"></asp:Label></td>
                        <td align=center><asp:Label ID="lblApprovedDate" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr> 
                    
                  </table>
                </td>
               </tr>   
         </table>
        
        <table id="Table4" runat="server"  border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                font-family: Verdana">
            <tr>
                <td align="left" colspan="5" style="font-weight: bold; font-size: 10pt; vertical-align: middle;
                        text-transform: uppercase; font-family: Verdana; height: 30px; text-align: center"
                        valign="top">
                    DETAILS OF ADVANcE TAKEN</td>
            </tr>
        </table>
        
       <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                font-family: Verdana" id="Table5" onclick="return TABLE2_onclick()">
            <tr>
                 <asp:GridView ID="gvAdvPaid" runat="server" CellPadding="1" AutoGenerateColumns="False" Width="100%">
                            <Columns>
                            <asp:TemplateField>
                            
                                     <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Middle"  />
                            </asp:TemplateField>        
                                     <asp:BoundField DataField="AdvLoc" HeaderText="Branch Name">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemStyle HorizontalAlign=Left />
                                    </asp:BoundField>
                                    
                                    
                                    <asp:BoundField DataField="AdvDate" HeaderText="Date">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemStyle HorizontalAlign=Left />
                                    </asp:BoundField>
                                     
                                    <asp:BoundField DataField="VoucherRefNo" HeaderText="Voucher No.">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemStyle HorizontalAlign=Left />
                                    </asp:BoundField>
                                    
                                     <asp:BoundField DataField="AdvAmt" HeaderText="Amount">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemStyle HorizontalAlign=Right />
                                    </asp:BoundField>
                                    
                                    <asp:BoundField DataField="Signature" HeaderText="Paid By Sign">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemStyle HorizontalAlign=Left />
                                    </asp:BoundField>
                                <asp:BoundField HeaderText="Driver's Sign" />
                                <asp:BoundField HeaderText="Remark " />
                                    
                                                        
                            </Columns>
                        </asp:GridView>
            </tr>
        </table>
        <br />
        <table cellspacing="0" cellpadding="0" width="100%" align=left class="boxbg" border="0" >

        <tr style="background-color: white">
        <td style="font-weight: bold; width: 33%; height: 30px">Sign of Driver:</td>
        <td style="font-weight: bold; width: 33%; height: 30px">Sign of Fleet Supervisor:</td>
        <td style="font-weight: bold; width: 34%; height: 30px">Sign of Fleet In-Charge:</td>
        </tr> 

        </table>
        
        </tr>
        </table>
    

    </form>
</body>
</html>
