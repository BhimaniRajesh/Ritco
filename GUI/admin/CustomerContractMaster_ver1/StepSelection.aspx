<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="StepSelection.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_StepSelection" %>

<asp:Content ID="cntone" ContentPlaceHolderID="MyCPH1" runat="server">
    <br />
        <asp:Table ID="Table1" runat="server" CssClass="blackfnt" >
             <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;ContractID  
                </asp:TableCell>
                <asp:TableCell>
                     : <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="redfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
                         <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
                </asp:TableCell>
                <asp:TableCell>
                : <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table> 
            <br /><br />
    <script type="text/javascript" language="javascript">
        function submitClick()
        {
            var optsundry =document.getElementById("ctl00_MyCPH1_optsundry");
            var optftl =document.getElementById("ctl00_MyCPH1_optftl");
            var optoda =document.getElementById("ctl00_MyCPH1_optoda");
            
            var optflatmultipoint =document.getElementById("ctl00_MyCPH1_optflatmultipoint");
            var optlocmultipoint =document.getElementById("ctl00_MyCPH1_optlocmultipoint");
            
            var optflatloading =document.getElementById("ctl00_MyCPH1_optflatloading");
            var optlocloading =document.getElementById("ctl00_MyCPH1_optlocloading");
            
            var optflatunloading =document.getElementById("ctl00_MyCPH1_optflatunloading");
            var optlocunloading =document.getElementById("ctl00_MyCPH1_optlocunloading");
              
            var cnt=0;
            
            if(optsundry.checked==true)
                cnt++;               
            
            if(optftl.checked==true)
                cnt++;
           
           if(optoda.checked==true)
                cnt++;
           
           if(optflatmultipoint.checked==true)
                cnt++;
           
           if(optlocmultipoint.checked==true)
                cnt++;
           
           if(optflatloading.checked==true)
                cnt++;
           
           if(optlocloading.checked==true)
                cnt++;
           
           if(optflatunloading.checked==true)
                cnt++;
           
           if(optlocunloading.checked==true)
                cnt++;
           
           
           if(cnt==0)
           {
                alert("Please Select any One Option");
                return false;
           }
           
            return true;
        }
    </script>
    <asp:Panel runat="server" Width="10in" HorizontalAlign="Center">
        <asp:Table Width="5in" runat="server" CssClass="boxbg" CellPadding="0" CellSpacing="1"
            BorderWidth="0">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Left" Font-Bold="true">
            &nbsp;Select Step
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trsundry" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optsundry" runat="server" GroupName="grvchoose"
                        CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Freight Charges - Sundry
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trftl" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optftl" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Freight Charges - FTL
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="troda" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optoda" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;ODA Charges
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trflatmultipoint" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optflatmultipoint" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Flat MultiPoint Charges
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trflatloading" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optflatloading" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Flat Loading Charges 
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trflatunloading" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optflatunloading" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Flat UnLoading Charges 
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trlocmultipoint" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optlocmultipoint" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Location Wise MultiPoint Charges
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trlocloading" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optlocloading" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Location Wise Loading Charges 
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trlocunloading" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optlocunloading" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Location Wise UnLoading Charges 
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trsubmit" runat="server" CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                    <asp:Button ID="btnSubmit" CssClass="blackfnt" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                        OnClientClick="javascript:return submitClick()" OnClick="btnSubmit_Click" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>
