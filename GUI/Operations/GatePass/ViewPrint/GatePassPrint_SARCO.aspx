<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GatePassPrint_SARCO.aspx.cs" Inherits="GUI_Operations_GatePass_ViewPrint_GatePassPrint_SARCO" %>

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
       <%-- table {border: solid 1px black}
         TR {border: solid 1px black}
         TD {border: solid 1px black}  --%>
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
        }   
         .print_chagresG
        {
           font-family:Sans Serif;
           font-size:13;
           horizontal-align:right;
           text-transform: uppercase;                              
        }      
        .print_labelRs
        {           
           padding-left:15px;
        }  
        .print_DateF
        {
           padding-left:5px;
        } 
        .print_FromF
        {
           padding-left:5px;
        } 
        .print_NoG
        {
           padding-left:10px;
        }   
        .print_DateG
        {
           padding-left:20px;
        }    
        .print_NameG
        {
           padding-left:22px;
        } 
        .print_GRNoG
        {
           padding-left:15px;
        } 
        .print_GRDateG
        {
           padding-left:5px;
        } 
        .print_FromG
        {
           padding-left:25px;
        }
        .print_PkgG
        {
           padding-left:5px;
        }
     </style>
</head>
<body onload="javascript:return printPage()" style="margin: 0px 0px 0px 0px; width: 0px;
    font-family: Lucida Console; font-size: 13; position: absolute; height: 0px;">
    <form id="form1" runat="server">
        <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in; height: 6in;"
            ID="pnlMain">
          <asp:Repeater ID="repdocket" runat="server" OnItemDataBound="repdocket_OnItemDataBound">
                <ItemTemplate>
                    <asp:Table ID="tblMain" runat="server" HorizontalAlign="center" BorderColor="black"
                        CellSpacing="0" CellPadding="0" BorderWidth="0" Width="100%" CssClass="print_sml">
                        <asp:TableRow Height="98px" VerticalAlign="Middle" BorderWidth="1" BorderColor="black"
                            ID="trHeader" runat="server">
                            <asp:TableCell HorizontalAlign="center" Width="390px" ID="tdMain" runat="server">
                    <%--<b>SARCO ROADLINES PVT. LTD.</b>--%></asp:TableCell>
                            <asp:TableCell HorizontalAlign="center" Width="50px">
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="center" Width="390px">
                   <%-- <b>SARCO ROADLINES PVT. LTD.</b>--%></asp:TableCell>
                            <asp:TableCell Width="175px">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Height="105px" VerticalAlign="Middle" BorderColor="black" ID="TableRow2"
                            runat="server">
                            <asp:TableCell Height="20px">
                                <asp:Table ID="Table1" runat="server" HorizontalAlign="center" CellSpacing="0" CellPadding="0"
                                    BorderWidth="0" Width="100%">
                                    <asp:TableRow Height="33px" VerticalAlign="Middle" BorderColor="black" ID="TableRow3"
                                        runat="server">
                                        <asp:TableCell BorderWidth="0">                                
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="20px" BorderColor="black" ID="TableRow4"                                        runat="server">
                                        <asp:TableCell>
                                            <asp:Table ID="Table2" runat="server" HorizontalAlign="center" BorderColor="black"
                                                CellSpacing="0" CellPadding="0" BorderWidth="0" Height="100%" Width="100%">
                                                <asp:TableRow VerticalAlign="bottom" BorderWidth="1" BorderColor="black" ID="TableRow7"
                                                    runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="265px" VerticalAlign="bottom">
                                                        <asp:Label ID="lblNoR" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"GATEPASSNO") %>'></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" VerticalAlign="bottom">
                                                        <asp:Label ID="lblDateR" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"GATEPASSDATE") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="20px" VerticalAlign="Middle" BorderWidth="1" BorderColor="black"
                                        ID="TableRow5" runat="server">
                                        <asp:TableCell BorderWidth="0">                                
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="20px" VerticalAlign="Middle" BorderWidth="0" BorderColor="black"
                                        ID="TableRow6" runat="server">
                                        <asp:TableCell>
                                            <asp:Table ID="Table3" runat="server" HorizontalAlign="center" BorderColor="black"
                                                CellSpacing="0" CellPadding="0" BorderWidth="0" Height="100%" Width="100%">
                                                <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow8" runat="server">
                                                    <asp:TableCell VerticalAlign="Middle">
                                                        <asp:Label ID="lblNameR" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"PARTY") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                            <asp:TableCell>                    
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:Table ID="Table4" runat="server" HorizontalAlign="left" BorderColor="black"
                                    CellSpacing="0" CellPadding="0" BorderWidth="0" Width="100%">
                                    <asp:TableRow Height="33px" VerticalAlign="Middle" BorderColor="black" ID="TableRow9"
                                        runat="server">
                                        <asp:TableCell BorderWidth="0">                                
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="20px" BorderWidth="0" BorderColor="black"
                                        ID="TableRow10" runat="server">
                                        <asp:TableCell HorizontalAlign="left">
                                            <asp:Table ID="Table5" runat="server" HorizontalAlign="left" BorderColor="black"
                                                CellSpacing="0" CellPadding="0" BorderWidth="0" Height="100%" Width="100%">
                                                <asp:TableRow VerticalAlign="Bottom" BorderColor="black" ID="TableRow11" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="280px" VerticalAlign="Bottom" CssClass="print_NoG">
                                                        <asp:Label ID="lblNoG" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"GATEPASSNO") %>'></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" VerticalAlign="Bottom" CssClass="print_DateG">
                                                        <asp:Label ID="lblDateG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"GATEPASSDATE") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="20px" VerticalAlign="Middle" BorderColor="black" ID="TableRow12"
                                        runat="server">
                                        <asp:TableCell BorderWidth="0">                                
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Height="20px" VerticalAlign="Middle" BorderWidth="0" BorderColor="black"
                                        ID="TableRow13" runat="server">
                                        <asp:TableCell HorizontalAlign="left">
                                            <asp:Table ID="Table6" runat="server" HorizontalAlign="left" BorderColor="black"
                                                CellSpacing="0" CellPadding="0" BorderWidth="0" Height="100%" Width="100%" >
                                                <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow14" runat="server">
                                                    <asp:TableCell Width="25px">                                                
                                                    </asp:TableCell>
                                                    <asp:TableCell VerticalAlign="Middle" CssClass="print_NameG">
                                                        <asp:Label ID="lblNameG" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"PARTY") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                            <asp:TableCell>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Height="270px" VerticalAlign="Middle" BorderWidth="0" BorderColor="black"
                            ID="TableRow1" runat="server">
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="Top">
                                <asp:Table ID="Table8" runat="server" HorizontalAlign="left" BorderColor="black"
                                    CellSpacing="0" CellPadding="0" BorderWidth="0">
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow17" runat="server">
                                        <asp:TableCell ColumnSpan="2" VerticalAlign="Top">
                                            <asp:Table ID="Table7" runat="server" HorizontalAlign="center" BorderColor="black"
                                                CellSpacing="0" CellPadding="0" BorderWidth="0" Width="100%">
                                                <asp:TableRow VerticalAlign="Middle" Height="25px" BorderColor="black" ID="TableRow16"
                                                    runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="110px" VerticalAlign="Middle">
                                                        <asp:Label ID="lblGrNoR" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"DOCKNO") %>'></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="115px" VerticalAlign="Middle" CssClass="print_DateF">
                                                        <asp:Label ID="lblDateGR" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"DOCKDate") %>'></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" VerticalAlign="Middle" CssClass="print_FromF">
                                                        <asp:Label ID="lblFromR" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"ORGNCD") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow20" runat="server">
                                        <asp:TableCell ColumnSpan="2" VerticalAlign="Top">
                                            <asp:Table ID="Table11" runat="server" HorizontalAlign="center" BorderColor="black"
                                                CellSpacing="0" CellPadding="0" BorderWidth="0" Height="20px" Width="100%">
                                                <asp:TableRow BorderColor="black" ID="TableRow21" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="90px" VerticalAlign="Middle">
                                                        <asp:Label ID="lblPkgR" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"pkgsno") %>'></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="155px" VerticalAlign="Middle">
                                                        <asp:Label ID="lblWeightR" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"CHRGWT") %>'></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" VerticalAlign="Middle">
                                                        <asp:Label ID="lblDateArrR" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"Arrived_DT") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow22" runat="server"
                                        Height="12px">
                                        <asp:TableCell ColumnSpan="2">
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow23" runat="server"
                                        Height="17px">
                                        <asp:TableCell Width="150px">
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                            <asp:Label ID="lblFreightF" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"freight") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow24" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                            <asp:Label ID="lblHammaliF" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"UCHG01") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow25" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                            <asp:Label ID="lblDeliverChargeF" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"UCHG06") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow26" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                            <asp:Label ID="lblOctRecR" CssClass="print_sml" runat="server" ></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow27" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                            <asp:Label ID="lblOctSerF" CssClass="print_sml" runat="server" ></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow28" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresF">
                                            <asp:Label ID="lblDemurragesF" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"SCHG14") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow29" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right">
                                            <asp:Label ID="lblDFF" CssClass="print_sml" runat="server" ></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow30" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right">
                                            <asp:Label ID="lblOtherF" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"SCHG03") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow31" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right">
                                            <asp:Label ID="lblTotalR" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Total") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" Height="30px" BorderColor="black" ID="TableRow45"
                                        runat="server">
                                        <asp:TableCell HorizontalAlign="left" VerticalAlign="Top" ColumnSpan="2" CssClass="print_labelRs">
                                            <asp:Label ID="lblRsR" CssClass="print_sml" runat="server"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="center" ID="TableCell3" runat="server">
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="Top">
                                <asp:Table ID="Table9" runat="server" HorizontalAlign="left" BorderColor="black"
                                    CellSpacing="0" CellPadding="0" BorderWidth="0">
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow18" runat="server">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:Table ID="Table10" runat="server" HorizontalAlign="left" BorderColor="black"
                                                CellSpacing="0" CellPadding="0" BorderWidth="0" Height="25px" Width="100%">
                                                <asp:TableRow Height="25px" BorderColor="black" ID="TableRow19"
                                                    runat="server">
                                                    <asp:TableCell Width="15px">                                                
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="130px" VerticalAlign="Middle" CssClass="print_GRNoG">
                                                        <asp:Label ID="lblGrNoG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"DOCKNO") %>'></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" VerticalAlign="Middle" CssClass="print_GRDateG">
                                                        <asp:Label ID="lblDateGG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"DOCKDATE") %>'></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" VerticalAlign="Middle" CssClass="print_FromG">
                                                        <asp:Label ID="lblFromG" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ORGNCD") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow32" runat="server">
                                        <asp:TableCell ColumnSpan="2" HorizontalAlign="left">
                                            <asp:Table ID="Table12" runat="server" HorizontalAlign="left" BorderColor="black"
                                                CellSpacing="0" CellPadding="0" BorderWidth="0" Height="20px">
                                                <asp:TableRow BorderColor="black" ID="TableRow33" runat="server">
                                                    <asp:TableCell Width="35px">                                                
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="100px" VerticalAlign="Middle" CssClass="print_PkgG">
                                                        <asp:Label ID="lblPkgG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"pkgsno") %>'></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="155px" VerticalAlign="Middle">
                                                        <asp:Label ID="lblWeightG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"CHRGWT") %>'></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="70px" VerticalAlign="Middle">
                                                        <asp:Label ID="lblDateArrG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"Arrived_DT") %>'></asp:Label>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow34" runat="server"
                                        Height="12px">
                                        <asp:TableCell ColumnSpan="2">
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow35" runat="server"
                                        Height="17px">
                                        <asp:TableCell Width="250px">
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresG">
                                            <asp:Label ID="lblFreightG" CssClass="print_sml" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"freight") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow36" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresG">
                                            <asp:Label ID="lblHammaliG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"UCHG01") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow37" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresG">
                                            <asp:Label ID="lblDeliverChargesG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"UCHG06") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow38" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresG">
                                            <asp:Label ID="lblOctRec" CssClass="print_sml" runat="server"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow39" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresG">
                                            <asp:Label ID="lblOctSerG" CssClass="print_sml" runat="server"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow40" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right" CssClass="print_chagresG">
                                            <asp:Label ID="lblDemurragesG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"SCHG14") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow41" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right">
                                            <asp:Label ID="lblDFG" CssClass="print_sml" runat="server"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow42" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right">
                                            <asp:Label ID="lblOtherG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"SCHG03") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" BorderColor="black" ID="TableRow43" runat="server"
                                        Height="17px">
                                        <asp:TableCell>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="right">
                                            <asp:Label ID="lblTotalG" CssClass="print_sml" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem,"Total") %>'></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow VerticalAlign="Middle" Height="30px" BorderColor="black" ID="TableRow44"
                                        runat="server">
                                        <asp:TableCell HorizontalAlign="left" VerticalAlign="Top" ColumnSpan="2" CssClass="print_labelRs">
                                            <asp:Label ID="lblRS" CssClass="print_sml" runat="server"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                            <asp:TableCell>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow VerticalAlign="Middle" Height="89px" BorderWidth="1" BorderColor="black"
                            ID="TableRow15" runat="server">
                            <asp:TableCell HorizontalAlign="center">                         
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="center" ID="TableCell1" runat="server">
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="center">
                            </asp:TableCell>
                            <asp:TableCell>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>
    </form>
</body>
</html>
