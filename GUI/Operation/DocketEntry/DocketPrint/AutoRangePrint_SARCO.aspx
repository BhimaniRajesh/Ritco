<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AutoRangePrint_SARCO.aspx.cs" Inherits="AutoRangePrint_SARCO" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Print Page</title>

    <script language="javascript" type="text/javascript">
     function printPage() 
     {       
        window.print();        
        return false;
        // style="margin: 0px 0px 0px 0px; width: 0px; font-family: Lucida Console; font-size: 14;
        // position: absolute; height: 0px;" 
     }
    </script>

    <style type="text/css">  
         <%--table {border: solid 1px black}
         tr {border: solid 1px black}
         td {border: solid 1px black}--%>
        .print_sml
        {
           font-family:Sans Serif;
           font-size:13;
           horizontal-align:left;
           text-transform: uppercase;
        }        
         .print_chagresF
        {
           font-family:Sans Serif;
           font-size:13;
           horizontal-align:left;
           text-transform: uppercase;
           padding-right:0px;
           padding-top:2px;
        }        
        .print_ConsignerPadding
        {           
           padding-left:135px;
        }
        .print_ConsigneePadding
        {           
           padding-left:160px;
        }
        .print_PKGPadding
        {           
           padding-top:5px;
        }  
         .print_RatePadding
        {           
           padding-top:5px;
           padding-left:10px;
        } 
        .print_ValuePadding
        {           
           padding-bottom:10px;
           padding-left:10px;
        }     
        .print_CompanyPadding
        {           
           padding-left:50px;
        }  
        .print_DatePadding
        {           
           padding-left:25px;
        } 
         .print_GCNoPadding
        {           
           padding-right:20px;
        }  
        .print_DescriptionPadding
        {           
           padding-Top:3px;
           padding-left:5px;
        }   
     </style>
</head>
<body onload="javascript:return printPage()" style="margin: 0px 0px 0px 0px; width: 0px;
    font-family: Lucida Console; font-size: 13; position: absolute; height: 0px;">
    <form id="form1" runat="server">
        <asp:Repeater ID="repdocket" runat="server">
            <ItemTemplate>
                <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in; height: 6in;"
                    ID="pnlMain">
                    <asp:Table ID="tblMain" runat="server" HorizontalAlign="left" BorderColor="black"
                        CellSpacing="0" CellPadding="0" BorderWidth="0" Width="100%" CssClass="print_sml">
                        <asp:TableRow Height="50px" VerticalAlign="Middle" BorderWidth="1" BorderColor="black"
                            ID="trHeader" runat="server">
                            <asp:TableCell ColumnSpan="4">                    </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Height="125px" VerticalAlign="Middle" BorderWidth="1" BorderColor="black"
                            ID="TableRow1" runat="server">
                            <asp:TableCell Width="225px">
                            </asp:TableCell>
                            <asp:TableCell Width="250px" VerticalAlign="Top">
                                <asp:Table ID="Table5" runat="server" HorizontalAlign="left" BorderColor="black"
                                    CellSpacing="0" CellPadding="0" BorderWidth="0" Width="100%" CssClass="print_sml">
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow21" runat="server">
                                        <asp:TableCell Height="25px" Width="50%"> 
                                        </asp:TableCell>
                                        <asp:TableCell> 
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow22" runat="server">
                                        <asp:TableCell Height="20px">                                    
                                        </asp:TableCell>
                                        <asp:TableCell> 
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow32" runat="server">
                                        <asp:TableCell Height="20px"> 
                                        </asp:TableCell>
                                        <asp:TableCell> 
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow33" runat="server">
                                        <asp:TableCell Height="20px"> 
                                        </asp:TableCell>
                                        <asp:TableCell> 
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow34" runat="server">
                                        <asp:TableCell Height="20px"> 
                                        </asp:TableCell>
                                        <asp:TableCell> 
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow35" runat="server">
                                        <asp:TableCell Height="25px">                                   
                                        </asp:TableCell>
                                        <asp:TableCell> 
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow36" runat="server">
                                        <asp:TableCell ColumnSpan="2" CssClass="print_CompanyPadding" Height="15px">
                                            <asp:Label ID="lblCompany" CssClass="print_sml" runat="server"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow37" runat="server">
                                        <asp:TableCell Height="15px" CssClass="print_CompanyPadding">
                                            <asp:Label ID="lblPolicyNo" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"policyno") %>'></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell CssClass="print_DatePadding">
                                            <asp:Label ID="lblFDate" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"policydt") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow38" runat="server">
                                        <asp:TableCell Height="15px" CssClass="print_CompanyPadding">
                                            <asp:Label ID="lblAmount" CssClass="print_sml" runat="server"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell CssClass="print_DatePadding">
                                            <asp:Label ID="lblTDate" CssClass="print_sml" runat="server"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                            <asp:TableCell Width="325px" VerticalAlign="Top">
                                <asp:Table ID="Table1" runat="server" HorizontalAlign="left" BorderColor="black"
                                    CellSpacing="0" CellPadding="0" BorderWidth="0" Width="100%" CssClass="print_sml">
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow5" runat="server">
                                        <asp:TableCell Height="25px"> 
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow6" runat="server">
                                        <asp:TableCell VerticalAlign="Top" Height="62px" >
                                            <asp:TextBox ID="txtAddress" ReadOnly="true"  Width="100%" BorderStyle="None" runat="server" CssClass="print_sml" Text='<%#DataBinder.Eval(Container.DataItem,"orgnaddr") %>'
                                            BackColor="white" TextMode="MultiLine" Rows="3" Style="overflow: hidden;"></asp:TextBox>
                                            <%--<asp:Label ID="lblAddress" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"orgnaddr") %>'></asp:Label>--%>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                   <%-- <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow7" runat="server">
                                        <asp:TableCell Height="15px"> 
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow8" runat="server">
                                        <asp:TableCell Height="15px"> 
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow9" runat="server">
                                        <asp:TableCell Height="15px"> 
                                        </asp:TableCell>
                                    </asp:TableRow>--%>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow10" runat="server">
                                        <asp:TableCell Height="25px" HorizontalAlign="Center" CssClass="print_GCNoPadding">
                                            <asp:Label ID="lblGCNo" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow11" runat="server">
                                        <asp:TableCell Height="20px" CssClass="print_CompanyPadding" VerticalAlign="Top">
                                            <asp:Label ID="lblDate" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"dockdate") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow12" runat="server">
                                        <asp:TableCell Height="20px" CssClass="print_CompanyPadding">
                                            <asp:Label ID="lblFrom" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"from_loc") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow13" runat="server">
                                        <asp:TableCell Height="25px" CssClass="print_CompanyPadding">
                                            <asp:Label ID="lblTo" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"to_loc") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                            <asp:TableCell>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Height="25px" BorderWidth="1" BorderColor="black" ID="TableRow2" runat="server">
                            <asp:TableCell ColumnSpan="4" VerticalAlign="Bottom" CssClass="print_ConsignerPadding">
                            <asp:Label ID="lblConsignerNameAdd" CssClass="print_sml" Width="100%" runat="server"
                                    Text='<%#DataBinder.Eval(Container.DataItem,"csgnaddr") %>'></asp:Label>
                                <%--<asp:TextBox ID="txtConsignerNameAdd" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"csgenm") %>'
                                    CssClass="print_sml" ReadOnly="true" BorderStyle="None" Width="100%"></asp:TextBox>--%>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Height="25px" BorderWidth="1" BorderColor="black" ID="TableRow3" runat="server">
                            <asp:TableCell ColumnSpan="4" VerticalAlign="Bottom" CssClass="print_ConsigneePadding">
                            <asp:Label ID="lblConsineeNameAdd" CssClass="print_sml" Width="100%" runat="server"
                                    Text='<%#DataBinder.Eval(Container.DataItem,"csgnaddr") %>'></asp:Label>
                               <%-- <asp:TextBox ID="txtConsineeNameAdd" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"csgnnm") %>'
                                    CssClass="print_sml" ReadOnly="true" BorderStyle="None" Width="100%"></asp:TextBox>--%>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Height="225px" VerticalAlign="Middle" BorderWidth="1" BorderColor="black"
                            ID="TableRow4" runat="server">
                            <asp:TableCell ColumnSpan="4">
                                <asp:Table ID="Table2" runat="server" HorizontalAlign="left" BorderColor="black"
                                    CellSpacing="0" CellPadding="0" BorderWidth="0" Height="100%" Width="100%" CssClass="print_sml">
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow15" runat="server">
                                        <asp:TableCell ColumnSpan="6" Height="40px"> </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow14" runat="server">
                                        <asp:TableCell Width="30px" CssClass="print_PKGPadding" VerticalAlign="Top" HorizontalAlign="center">
                                            <asp:Label ID="lblPkgNo" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"pkgsno") %>'></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Width="360px" VerticalAlign="Top" HorizontalAlign="Left" CssClass="print_DescriptionPadding">
                                            <asp:TextBox ID="txtDescription" ReadOnly="true" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"prodname") %>'
                                                CssClass="print_sml" BorderStyle="None" Rows="8" Width="100%" Style="overflow: hidden;"
                                                TextMode="MultiLine"></asp:TextBox>
                                        </asp:TableCell>
                                        <asp:TableCell Width="150px" VerticalAlign="Top">
                                            <asp:Table ID="Table3" runat="server" HorizontalAlign="left" BorderColor="black"
                                                CellSpacing="0" CellPadding="0" BorderWidth="0" Height="100%" Width="100%" CssClass="print_sml">
                                                <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow17" runat="server">
                                                    <asp:TableCell Height="30px" VerticalAlign="Top" CssClass="print_RatePadding">
                                                        <asp:Label ID="lblRatePerKg" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"FRT_RATE") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow18" runat="server">
                                                    <asp:TableCell Height="30px" VerticalAlign="Top" CssClass="print_RatePadding">
                                                        <asp:Label ID="lblActualWeight" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"actuwt") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow19" runat="server">
                                                    <asp:TableCell Height="30px" VerticalAlign="Top" CssClass="print_RatePadding">
                                                        <asp:Label ID="lblCharged" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"chrgwt") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BorderWidth="1" BorderColor="black" ID="TableRow20" runat="server">
                                                    <asp:TableCell Height="30px" VerticalAlign="Bottom" CssClass="print_ValuePadding">
                                                        <asp:Label ID="lblValue" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"InvoiceAmount") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                        <asp:TableCell Width="240px" VerticalAlign="Top">
                                            <asp:Table ID="Table4" runat="server" HorizontalAlign="left" BorderColor="black"
                                                CellSpacing="0" CellPadding="0" BorderWidth="0" Width="100%" CssClass="print_sml">
                                                <asp:TableRow VerticalAlign="top" BorderColor="black" ID="TableRow23" runat="server"
                                                    Height="12px">
                                                    <asp:TableCell Width="140px">
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                                        <asp:Label ID="lblFreightF" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"freight") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow24" runat="server"
                                                    Height="17px">
                                                    <asp:TableCell>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                                        <asp:Label ID="lblHammaliF" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"UCHG07") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow25" runat="server"
                                                    Height="17px">
                                                    <asp:TableCell>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                                        <asp:Label ID="lblStCharges" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG01") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow26" runat="server"
                                                    Height="17px">
                                                    <asp:TableCell>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                                        <asp:Label ID="lblPF" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"UCHG05") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow27" runat="server"
                                                    Height="17px">
                                                    <asp:TableCell>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                                        <asp:Label ID="lblCartage" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG15") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow28" runat="server"
                                                    Height="17px">
                                                    <asp:TableCell>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                                        <asp:Label ID="lblCollection" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG20") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow29" runat="server"
                                                    Height="17px">
                                                    <asp:TableCell>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                                        <asp:Label ID="lblDoorDelivery" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG08") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow30" runat="server"
                                                    Height="17px">
                                                    <asp:TableCell>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                                        <asp:Label ID="lblServiceTax" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"servicetax") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow31" runat="server"
                                                    Height="35px">
                                                    <asp:TableCell>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                                        <asp:Label ID="lblTotal" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Total") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                        <asp:TableCell> 
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow VerticalAlign="Middle" BorderWidth="1" BorderColor="black" ID="TableRow16"
                            runat="server">
                            <asp:TableCell ColumnSpan="4">                       
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:Panel>
            </ItemTemplate>
        </asp:Repeater>
    </form>
</body>
</html>
