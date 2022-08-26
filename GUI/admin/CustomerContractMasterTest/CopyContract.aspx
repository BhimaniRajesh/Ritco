<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="CopyContract.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_CopyContract" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="cntone" runat="server">

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript">
        
    /// ENDOF POPUP FUNCTIONS
    
    function submitClick()
    {
        var txtcontractid=document.getElementById("ctl00_MyCPH1_txtcontractid");
        var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
        var btnsubmit=document.getElementById("ctl00_MyCPH1_btnsubmit");
        var lblmessage=document.getElementById("ctl00_MyCPH1_lblmessage");
        
        if(hdnajaxstate.value!="0")
            {
                alert("Let the Internal Processes Over.Kind wait for sometime or LogOn again.");
                return false;
            }
            
        if(txtcontractid.value=="")
        {
            if(!confirm("No ContractID specified. This will Enter a Blank Contract. Do you Want to Proceed ??"))
                return false;
        }
        
         btnsubmit.style.display="none";
        lblmessage.style.display="block";
        
        return true;
    }
    
    function openPopUp()
    {
        window.open("PopUpContractID.aspx?sid=" + Math.random(),null,"height=185,width=550,resizable=no,scrollbars=no,left=310,top=100");
        return false;
    }
    
    function contractIDBlur()
    {
    
        var txt=document.getElementById("ctl00_MyCPH1_txtcontractid");
        var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
        var imgtick=document.getElementById("ctl00_MyCPH1_imgtick");
        hdnajaxstate.value="1";
        
            if(txt.value=="")
            {
                imgtick.style.display="none";
                hdnajaxstate.value="0";
                return false;
            }
            
            txt.value=txt.value.toUpperCase();
        
            var findobj=false;
            findobj=GetXMLHttpObject();
            if(findobj)
            {
             var strpg="AjaxResponse.aspx?mode=check&code1=contractidtest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
             findobj.open("GET",strpg);
             findobj.onreadystatechange=function()
                 {
                     if((findobj.readyState==4) && (findobj.status==200))
                        {
                           var res=findobj.responseText.split("|");
                              if(res[0]=="false")
                                 { 
                                    alert(res[1]);
                                    txt.value="";
                                    txt.focus();
                                    imgtick.style.display="none";
                                 }
                              else if(res[0]=="true")
                              {
                                hdnajaxstate.value="0";
                                imgtick.style.display="block";
                              }
                        }
                 }
                 
            findobj.send(null);
            }
    
    }
    </script>

    <asp:UpdatePanel ID="updtwo" runat="server">
        <ContentTemplate>
         
        
            <br />
            <br />
            <br />
            <asp:Panel Width="10in" runat="server" HorizontalAlign="Center">
                <asp:Table runat="server" Width="70%" CssClass="boxbg" CellPadding="1" CellSpacing="1"
                    BorderWidth="0">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell ColumnSpan="2" CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center">Copy Contract</asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="White">
                        <asp:TableCell HorizontalAlign="Left">New ContractID</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Left">
                            <asp:Label ID="lblcontractid" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="White">
                        <asp:TableCell HorizontalAlign="Left">Customer Code & Name</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Left">
                            <asp:Label ID="lblcustname" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="White">
                        <asp:TableCell HorizontalAlign="Left">Existing Contract ID</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Left">
                            <asp:Table runat="server">
                                <asp:TableRow>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtcontractid" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                            onblur="javascript:return contractIDBlur()" Width="100px" MaxLength="20"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Image ID="imgtick" onclick="javascript:return openPopUp()" runat="server" onmouseover="this.style.cursor='pointer'"
                                         Height="15px" Width="15px"   ImageUrl="~/GUI/images/dockettick.jpg" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <input type="button" id="btnpopup" class="blackfnt" value="..." runat="server" onclick="javascript:return openPopUp()" onmouseover="this.style.cursor='pointer'" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Button ID="btnsubmit" CssClass="blackfnt" OnClientClick="javascript:return submitClick()"
                                OnClick="btnsubmit_Click" runat="server" Text="Submit" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                 
                <br />
                <br />
                <asp:Label ID="lblmessage" Style="display: none;" runat="server" CssClass="redfnt"
                    Font-Bold="true">Copying a Contract May Take Several Minutes. Please Wait......</asp:Label>
                <asp:HiddenField ID="hdnajaxstate" Value="0" runat="server" />
                <asp:HiddenField ID="hdnpaybas" Value="0" runat="server" />
                <asp:HiddenField ID="hdnstartdate" Value="0" runat="server" />
                <asp:HiddenField ID="hdnenddate" Value="0" runat="server" />
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
