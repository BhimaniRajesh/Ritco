<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DocketCustomization_Step2.aspx.cs" Inherits="GUI_admin_DocketCustomization_DocketCustomization_Step2"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <br />

    <script type="text/javascript" src="../../images/commonJs.js" language="javascript"></script>

    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript">

        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();

    function optDtBlwClick()
    {

        var optdtblwnodays=document.getElementById("ctl00_MyCPH1_optdtblwnodays");
        var txtdtblwnodays=document.getElementById("ctl00_MyCPH1_txtdtblwnodays");
        
        var optdtblwtilldate=document.getElementById("ctl00_MyCPH1_optdtblwtilldate");
        var txtblwdate=document.getElementById("ctl00_MyCPH1_txtblwdate");
        var lblblwimage=document.getElementById("ctl00_MyCPH1_lblblwimage");

        if(optdtblwnodays.checked==true)
            txtdtblwnodays.style.display="block";
        else
            txtdtblwnodays.style.display="none";

        if(optdtblwtilldate.checked==true)
            {
                txtblwdate.style.display="block";
                lblblwimage.style.display="block";
            }
        else
            {
                txtblwdate.style.display="none";
                lblblwimage.style.display="none";
            }
            
        return true;
    }
    
    
    function optDtAbvClick()
    {

        var optdtabvnodays=document.getElementById("ctl00_MyCPH1_optdtabvnodays");
        var txtdtabvnodays=document.getElementById("ctl00_MyCPH1_txtdtabvnodays");
        
        var optdtabvtilldate=document.getElementById("ctl00_MyCPH1_optdtabvtilldate");
        var txtabvdate=document.getElementById("ctl00_MyCPH1_txtabvdate");
        var lblabvimage=document.getElementById("ctl00_MyCPH1_lblabvimage");
        
        if(optdtabvnodays.checked==true)
            txtdtabvnodays.style.display="block";
        else
            txtdtabvnodays.style.display="none";

        if(optdtabvtilldate.checked==true)
            {
                txtabvdate.style.display="block";
                lblabvimage.style.display="block";
            }
        else
            {
                txtabvdate.style.display="none";
                lblabvimage.style.display="none";
            }

        return true;
    }
    

    </script>

    <asp:Panel runat="server" Width="10in">
        <asp:Table runat="server" Width="100%">
            <asp:TableRow>
                <asp:TableCell Font-Bold="true">
                    <asp:Table ID="Table4" runat="server" CellSpacing="1" Width="100%" BorderWidth="0"
                        CssClass="boxbg">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell Font-Bold="true" ColumnSpan="4">Docket Entry Cutomization Form - 2
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>
                Computerized Entry for Allowed Locations
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optcomputerized" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                            <asp:TableCell>
                Serial Wise Docket Entry
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optdcrserial" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>Void Docket Application</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optdcrvoid" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                            <asp:TableCell>FTL Type Filter from Customer Contract</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optftlfilter" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>
                            Business Type from DCR
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optbusinessdcr" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                            <asp:TableCell>TransMode from Business Type</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="opttranmodedcr" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>Document Details Based On</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optdocdetails" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="S">State </asp:ListItem>
                                    <asp:ListItem Value="C">City</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                            <asp:TableCell>Use Intra State</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optintrastate" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>Consignor-Consignee From Master</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optmastercsgne" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                            <asp:TableCell> Cities from Master</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optmastercities" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>USE Load Type</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optloadtype" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                            <asp:TableCell>Use Dopi Number</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optdopi" RepeatDirection="Horizontal" CssClass="blackfnt"
                                    Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>Use Multi Pickup-Delivery</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optmultipickupdel" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                            <asp:TableCell>Use Pro-Rata Charges</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optprorata" RepeatDirection="Horizontal"
                                    CssClass="blackfnt" Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell> EDD from Transit Master</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="opteddtransit" RepeatDirection="Vertical"
                                    CssClass="blackfnt">
                                    <asp:ListItem Value="C">Only From Customer Contracts</asp:ListItem>
                                    <asp:ListItem Value="CT">First Customer Contract Master,<br /> If not found then from Transit Master</asp:ListItem>
                                    <asp:ListItem Value="T">Only From Transit Master</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                            <asp:TableCell> No of Days to be added in EDD, <br />
                                not in case of Local Consignment</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txttrdays" runat="server" Text="0" onkeypress="javascript:return validInt(event)"
                                    CssClass="blackfnt" MaxLength="2" Width="30px" Style="text-align: right;" BorderStyle="Groove"></asp:TextBox></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>Round Off rule for SubTotal,Service Tax, Edu Cess,<br /> Higher Edu Cess and Docket Total</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optround" RepeatDirection="Horizontal" CssClass="blackfnt"
                                    Width="2in">
                                    <asp:ListItem Value="Y">Yes</asp:ListItem>
                                    <asp:ListItem Value="N">No</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                            <asp:TableCell>Charges Application in Docket Entry and Contracts</asp:TableCell>
                            <asp:TableCell>
                                <asp:RadioButtonList runat="server" ID="optchargerule" RepeatDirection="Vertical"
                                    CssClass="blackfnt">
                                    <asp:ListItem Value="NONE">Default</asp:ListItem>
                                    <asp:ListItem Value="BUT">Business Type Wise</asp:ListItem>
                                    <asp:ListItem Value="SVCTYP">Service Type Wise</asp:ListItem>
                                </asp:RadioButtonList></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>Docket Date</asp:TableCell>
                            <asp:TableCell ColumnSpan="3">
                                <asp:Table runat="server" CssClass="boxbg" Width="100%" CellSpacing="1">
                                    <asp:TableRow CssClass="bgbluegrey">
                                        <asp:TableCell ColumnSpan="2" Font-Bold="true">
                                            <asp:CheckBox ID="chkbydate" runat="server" />
                                            By Date</asp:TableCell>
                                        <asp:TableCell ColumnSpan="2" Font-Bold="true" style="display:none;">
                                            <asp:CheckBox ID="chkbyhour" runat="server" />
                                            By Hour</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell VerticalAlign="Top" Width="150px">
                                            Below
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Table runat="server">
                                                <asp:TableRow>
                                                    <asp:TableCell >
                                                        <asp:RadioButton ID="optdtblwnodays" onclick="javascript:return optDtBlwClick()"
                                                            GroupName="dtblw" Text="No of Days" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txtdtblwnodays" Width="50px" MaxLength="3" BorderStyle="Groove"
                                                            CssClass="blackfnt" Style="text-align: right;" runat="server"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                               
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:RadioButton ID="optdtblwtilldate" onclick="javascript:return optDtBlwClick()"
                                                            GroupName="dtblw" Text="Till Date" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="Left">
                                                        <asp:Table runat="server">
                                                            <asp:TableRow>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtblwdate" style="display:none;" runat="server" MaxLength="10" BorderStyle="Groove" Width="70px" CssClass="blackfnt" onkeypress="javascript:return validDate(event)"></asp:TextBox></asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:Label ID="lblblwimage" style="display:none;" runat="server">
                                                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtblwdate,'ancblwdate','dd/MM/yyyy'); return false;"
                                                            name="ancblwdate" id="ancblwdate">
                                                            <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0" />
                                                            </a>
                                                                    </asp:Label></asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                        <asp:TableCell VerticalAlign="Top" style="display:none;">Below</asp:TableCell>
                                        <asp:TableCell VerticalAlign="Top" style="display:none;">
                                            <asp:Table runat="server" style="display:none;">
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:RadioButton ID="opthrblwhours" GroupName="blwhr" runat="server" Text="No of hours" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txthrblwhours" Width="50px" CssClass="blackfnt" MaxLength="2" BorderStyle="Groove"
                                                            Style="text-align: right;" runat="server"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell VerticalAlign="Top" Width="150px">
                                            Above
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Table ID="Table1" runat="server">
                                             
                                                <asp:TableRow>
                                                    <asp:TableCell >
                                                        <asp:RadioButton ID="optdtabvnodays" onclick="javascript:return optDtAbvClick()"
                                                            GroupName="dtabv" Text="No of Days" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell >
                                                        <asp:TextBox ID="txtdtabvnodays" CssClass="blackfnt" Width="50px" MaxLength="2" BorderStyle="Groove"
                                                            Style="text-align: right;" runat="server"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:RadioButton ID="optdtabvtilldate" onclick="javascript:return optDtAbvClick()"
                                                            GroupName="dtabv" Text="Till Date" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="Left">
                                                        <asp:Table runat="server">
                                                            <asp:TableRow>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtabvdate" style="display:none;" runat="server" MaxLength="10" BorderStyle="Groove" 
                                                                        Width="70px" CssClass="blackfnt" onkeypress="javascript:return validDate(event)">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:Label ID="lblabvimage" style="display:none;" runat="server">
                                                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtabvdate,'ancabvdate','dd/MM/yyyy'); return false;"
                                                            name="ancabvdate" id="a1">
                                                            <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0" />
                                                            </a>
                                                                    </asp:Label>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                        <asp:TableCell VerticalAlign="Top" style="display:none;">Above</asp:TableCell>
                                        <asp:TableCell VerticalAlign="Top" style="display:none;">
                                            <asp:Table ID="Table2" runat="server" style="display:none;">
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:RadioButton ID="opthrabvhours" GroupName="hrabv" runat="server" Text="No of hours" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txthrabvhours" Width="50px" CssClass="blackfnt" MaxLength="2" BorderStyle="Groove"
                                                            Style="text-align: right;" runat="server"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ColumnSpan="3" HorizontalAlign="center">
                    <asp:Table ID="Table5" runat="server" CellSpacing="1" Width="100%" CssClass="boxbg">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell Font-Bold="true">
                                <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" Text="Submit"
                                    CssClass="blackfnt" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />
        <br />
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
            z-index: 99;">
        </div>
    </asp:Panel>
</asp:Content>
