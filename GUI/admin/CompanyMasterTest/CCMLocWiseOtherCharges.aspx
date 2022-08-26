<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CCMLocWiseOtherCharges.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_DeliveryPointCharges"
    Title="Untitled Page" %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">

function windowPopUp(mode,ctlid,tbl)
{
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=4row";
    confirmWin=window.open(url,"",winOpts);
    return false;
}


function locTest(txtid,testtype)
{
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    hdnajaxstate.value="1";

    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
    var txt=document.getElementById(txtid);
    if(txt.value=="") 
    {   
        hdnajaxstate.value="0";
        return false;
    }
   
    txt.value=txt.value.toUpperCase();
    var strpg="";
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
         if(testtype=="citytest")
            strpg="AjaxResponse.aspx?mode=check&code1=citytest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
         else if(testtype=="loctest")
             strpg="AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
         else if(testtype=="zonetest")
             strpg="AjaxResponse.aspx?mode=check&code1=zonetest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();

     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                      var res=findobj.responseText.split("|");
                      if(res[0]=="false")
                         {
                            if(testtype=="citytest")
                                alert("City doesn't Exists...");
                            else if(testtype=="loctest")
                                alert("Location doesn't Exists...");
                            else if(testtype=="zonetest")
                                alert("Region doesn't Exists...");
                            txt.value="";
                            txt.focus();
                            hdnajaxstate.value="0";
                            return false;
                         }
                      else if(res[0]=="true")
                      {
                            hdnajaxstate.value="0";
                      }
                }
         }
         
    findobj.send(null);
    }

   return true;
}


  function submitValidation()
     {
        var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
        if(hdnajaxstate.value=="1")
        {
            alert("Let the Internal Processes over. Please wait 5-10 seconds or LogOut.");
            return false;
        }
        
        var grid =  document.getElementById("ctl00_MyCPH1_grvcharges");
        var len=parseInt(grid.rows.length);
        var pref="";
        var cnt=0;
        for(var i=2;i<=len;i++)
        {
            if(i<10)
                pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
            else
                pref = "ctl00_MyCPH1_grvcharges_ctl"+ i + "_";
            
             var txtfrom = document.getElementById(pref+"txtfrom");
             var txtto = document.getElementById(pref+"txtto");
             var chkyes = document.getElementById(pref+"chkyes");
            
            if(chkyes.checked==true)
            {
             cnt++;
                
                if(txtfrom.value=="")
                {
                    alert("Please Enter From Location");
                    txtfrom.focus();
                    return false;
                }
                
                if(txtto.value=="")
                {
                    alert("Please Enter To Location");
                    txtto.focus();
                    return false;
                }
                
                for(var j=2;j<len;j++)
                {
                    var jref="";
                    if(j<10)
                        jref = "ctl00_MyCPH1_grvcharges_ctl0" + j + "_";
                    else
                        jref = "ctl00_MyCPH1_grvcharges_ctl"+ j + "_";
                    
                    var txtjfrom = document.getElementById(jref+"txtfrom");
                    var txtjto = document.getElementById(jref+"txtto");
                    var chkjyes = document.getElementById(jref+"chkyes");
                    
                    if(chkjyes.checked==true)
                    {
                    
                    if(i!=j)
                    {
                    
                        if(txtjfrom.value=="")
                        {
                            alert("Please Enter From Location");
                            txtjfrom.focus();
                            return false;
                        }
                        
                        if(txtjto.value=="")
                        {
                            alert("Please Enter To Location");
                            txtto.focus();
                            return false;
                        }
                        
                        if(txtto.value==txtjto.value && txtfrom.value==txtjfrom.value)
                        {
                            alert("No Two  pair should be same.Please Enter Another Location");
                            txtto.value="";
                            txtto.focus();
                            return false;
                        }
                        
                    } // i!=j
                    }// chk j yes
                } //  J loop
            
            } // Check of YES/NO        

        } // I loop
        
        if(cnt==0)
        {
            alert("Please Select Atleast one Record........")    ;
            return false;
        }
        return true;
    }
    </script>

    <asp:UpdatePanel runat="server" ID="updone">
        <ContentTemplate>
            <cust:CustInfo runat="server" ID="cstheader" />
            <br />
            <asp:Panel runat="server" Width="10in">
                <asp:Table runat="server" Width="100%">
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell ColumnSpan="2" CssClass="blackfnt">
                            Please Note : &nbsp;<font class='redfnt'>Existing Data will be Replaced, if any</font>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell ColumnSpan="2" CssClass="blackfnt">
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Table ID="Table1" HorizontalAlign="Left" runat="server" CellSpacing="1" CssClass="boxbg"
                                Width="5in">
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell Width="50%" HorizontalAlign="Left">Charge Name
                                    </asp:TableCell>
                                    <asp:TableCell Width="50%" HorizontalAlign="Left">
                                        <asp:Label ID="lblchargename" runat="server" CssClass="blackfnt"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell Width="50%" HorizontalAlign="Left">Matrix Type
                                    </asp:TableCell>
                                    <asp:TableCell Width="50%" HorizontalAlign="Left">
                                        <asp:Label ID="lblmatrixtype" runat="server" CssClass="blackfnt"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell Width="50%" HorizontalAlign="Left">Trans Mode
                                    </asp:TableCell>
                                    <asp:TableCell Width="50%" HorizontalAlign="Left">
                                        <asp:Label ID="lbltransmode" runat="server" CssClass="blackfnt"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow Style="display: none;" CssClass="bgwhite">
                                    <asp:TableCell Width="50%" HorizontalAlign="Left">From Location Filter
                                    </asp:TableCell>
                                    <asp:TableCell Width="50%" HorizontalAlign="Left">
                                        <asp:Label ID="lblfilterfrom" runat="server" CssClass="blackfnt"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell Width="50%" HorizontalAlign="Left">Location Filter
                                    </asp:TableCell>
                                    <asp:TableCell Width="50%" HorizontalAlign="Left">
                                        <asp:Label ID="lblfilterto" runat="server" CssClass="blackfnt"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                            <br />
                            <br />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Table ID="tblmain" CellSpacing="1" CssClass="boxbg" runat="server">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell ColumnSpan="2" Font-Bold="true">Delivery Point Charges
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell Width="20%">Enter No of Rows
                                    </asp:TableCell>
                                    <asp:TableCell Width="80%">
                                        <asp:TextBox ID="txtrows" Width="40px" Style="text-align: right;" onkeypress="javascript:return validInt(event)"
                                            BorderStyle="Groove" MaxLength="2" CssClass="blackfnt" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnaddrows" runat="server" OnClick="btnaddrows_Click" CssClass="blackfnt"
                                            Text="Add New Rows" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell ColumnSpan="2">
                                        <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                                            CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                            BackColor="#8ba0e5" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                                            AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" EmptyDataText="No Records Found..."
                                            OnRowDataBound="grvcharges_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkyes" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                    <HeaderTemplate>
                                                        From 
                                                        <input type="button" id="btnfrom" runat="server" class="blackfnt" value="...." />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtfrom" Width="50px" Text='<%# DataBinder.Eval( Container.DataItem,"fromloc") %>'
                                                                        BorderStyle="Groove" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <input type="button" id="btnfrom" runat="server" onclick="return false;" class="blackfnt"
                                                                        value="...." />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                    <HeaderTemplate>
                                                        To
                                                        <input type="button" id="btnto" runat="server" class="blackfnt" value="...." />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtto" Width="50px" Text='<%# DataBinder.Eval( Container.DataItem,"toloc") %>'
                                                                        BorderStyle="Groove" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <input type="button" id="btnto" runat="server" onclick="return false;" class="blackfnt"
                                                                        value="...." />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Mimimum Charge(in RS)
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtminrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"minrate") %>'
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            onblur="javascript:return this.value=roundNumber(this.value,2)" Width="50px"
                                                            runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Charge Rate
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"rate") %>'
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            onblur="javascript:return this.value=roundNumber(this.value,2)" Width="50px"
                                                            runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Rate Type
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlratetype" runat="server" CssClass="blackfnt" BackColor="white">
                                                            <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                                            <asp:ListItem Value="W" Text="PerKG"></asp:ListItem>
                                                            <asp:ListItem Value="P" Text="PerPKG"></asp:ListItem>
                                                            <asp:ListItem Value="T" Text="PerTon"></asp:ListItem>
                                                            <asp:ListItem Value="F" Text="Flat(in RS)"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Maximum Charge(in Rs)
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtmaxrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"maxrate") %>'
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            onblur="javascript:return this.value=roundNumber(this.value,2)" Width="50px"
                                                            runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell ColumnSpan="2">
                                        <asp:Button ID="btnsubmit" CssClass="blackfnt" Text="Submit" runat="server" OnClick="btnsubmit_Click"
                                            OnClientClick="javascript:return submitValidation()" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="hdncustcode" runat="server" />
    <asp:HiddenField ID="hdncontractid" runat="server" />
    <asp:HiddenField ID="hdnmatrixtype" runat="server" />
    <asp:HiddenField ID="hdnchargecode" runat="server" />
    <asp:HiddenField ID="hdntransmode" runat="server" />
    <asp:HiddenField ID="hdnchargetype" runat="server" />
    <asp:HiddenField ID="hdnbasedon" runat="server" />
    <asp:HiddenField ID="hdnbasecode" runat="server" />
    <asp:HiddenField ID="hdnfrom" runat="server" />
    <asp:HiddenField ID="hdnto" runat="server" />
    <asp:HiddenField ID="hdnajaxstate" runat="server" />
</asp:Content>
