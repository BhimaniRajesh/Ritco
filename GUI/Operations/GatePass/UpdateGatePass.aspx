<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="UpdateGatePass.aspx.cs" Inherits="GUI_Operations_GatePass_UpdateGatePass"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <br />
     <script type="text/javascript" language="javascript">
     
        function checkAll(id)
        {
            var grid=document.getElementById("ctl00_MyCPH1_grvgatepass");
            var len =parseInt(grid.rows.length);
            for(var i=2;i<=len;i++)
            {
                var pref="";
                if(i<10)
                    pref="ctl00_MyCPH1_grvgatepass_ctl0" + i + "_";
                else
                    pref="ctl00_MyCPH1_grvgatepass_ctl" + i + "_";
                    
               var chkheader=document.getElementById(id);
               var chkyes = document.getElementById(pref + "chkyes");
               if(chkheader.checked==true)
                    chkyes.checked=true;
               else
                    chkyes.checked=false;
                
            }
        return true;
        }
        
        
        function btnsubmitClick()
        {
            var grid=document.getElementById("ctl00_MyCPH1_grvgatepass");
            var len =parseInt(grid.rows.length);
            var cnt=0;
            for(var i=2;i<=len;i++)
            {
                var pref="";
                if(i<10)
                    pref="ctl00_MyCPH1_grvgatepass_ctl0" + i + "_";
                else
                    pref="ctl00_MyCPH1_grvgatepass_ctl" + i + "_";
                    
               var chkyes = document.getElementById(pref + "chkyes");
               
               if(chkyes.checked==true)
                    cnt++;
            }
            
             if(cnt==0)
                {
                    alert("Please select atlease one record");
                    return false;
                }
            return true;
        }
     </script>
    
    <asp:Table runat="server" Width="10in">
        <asp:TableRow>
            <asp:TableCell HorizontalAlign="Left">
                <asp:Table runat="server" CellSpacing="1" Width="70%" BorderWidth="0" CssClass="boxbg">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="2">
                            Gate Pass Update
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell Width="50%">Date Range</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lbldaterange" CssClass="blackfnt" runat="server"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell>
                            Party Name
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblpartyname" CssClass="blackfnt" runat="server"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell>GatePass Number</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblgatepass" CssClass="blackfnt" runat="server"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
       
        <asp:TableRow>
            <asp:TableCell>
                <asp:GridView HorizontalAlign="left" ID="grvgatepass" runat="server" BorderWidth="0"
                    HeaderStyle-CssClass="bgbluegrey" CellSpacing="1" AllowSorting="true" CssClass="boxbg"
                    RowStyle-CssClass="bgwhite" RowStyle-HorizontalAlign="Center" AutoGenerateColumns="false" AlternatingRowStyle-BackColor="#f7f7f7"
                    Style="width: 70%;">
                    <Columns>
                        <asp:TemplateField HeaderText="">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkyesall" onclick="javascript:return checkAll(this.getAttribute('id'))" runat="server" CssClass="blackfnt" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkyes" runat="server" CssClass="blackfnt" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="GatePass No">
                            <ItemTemplate>
                                <asp:Label ID="lblgatepassno" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"gatepassno") %>'
                                    CssClass="blackfnt"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="date"  HeaderText="GatePass Date" />
                        <asp:BoundField DataField="partyname" HeaderText="Party Name" />
                        <asp:BoundField DataField="godown" HeaderText="GoDown" />
                    </Columns>
                </asp:GridView>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                <asp:Table CssClass="boxbg" runat="server" BorderWidth="0" CellSpacing="1" Width="70%">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center">
                            <asp:Button ID="btnsubmit" OnClick="btnsubmit_Click" OnClientClick="javascript:return btnsubmitClick()" CssClass="blackfnt" Text="Submit" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</asp:Content>
