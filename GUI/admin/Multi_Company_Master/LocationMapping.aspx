<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="LocationMapping.aspx.cs" Inherits="GUI_admin_Multi_Company_Master_LocationMapping"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript">
function popuplist(mode,ctlid,tbl)
{    
    var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
    var url="";
    url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
    confirmWin=window.open(url,"",winOpts);
    return false;
}
function CheckLocData()
{   
    var prefix = "ctl00_MyCPH1_";
    var txtLocCode = document.getElementById(prefix + "txtLocCode");
    if(txtLocCode.value == "")
    {
        alert("Please Enter Location Code");
        txtLocCode.focus();
        return false;
    }
    return true;
}
function LocBlur(id)
 {  
    var str="";
    for(var i=0;i<id.length-14;i++)
    {
        str+=id.charAt(i);
    }
    
    document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtLocCode=document.getElementById(id);
   
    var LocCode=txtLocCode.value;
    if(LocCode == "")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
        var strpg="CheckExist.aspx?mode=LocCode&Code=" + LocCode + "&sid=" + Math.random();
        findobj.open("GET",strpg,true);
        findobj.onreadystatechange=function()
        {
             if(findobj.readyState==4 && findobj.status==200)
              {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert("Location Code is not Valid... Please Enter Valid Location Code");
                        txtLocCode.value = "";
                        txtLocCode.focus();
                        return false;
                    }
              }
         }
    findobj.send(null);
    }
    return false;
} 
function radio_btn_selection(id)
{   
    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
    var rows=tbl.rows.length;
    for(i = 2; i <= rows ; i++)
    {   
        if(i<10)
        {
           radbtn_id=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_defaultyn");
        }
        else
        {
           radbtn_id=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_defaultyn");
        }
        if(radbtn_id != id)
        {
            radbtn_id.checked = false;
        }
    }
}
function CheckData()
{
    var HdnInsUpFlag = document.getElementById("ctl00_MyCPH1_HdnInsUpFlag");
    if(HdnInsUpFlag.value == "1")
    {
        var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var rows=tbl.rows.length;
        var Flag = false;
        for(i = 2; i <= rows ; i++)
        {   
            if(i<10)
            {
                radbtn_id=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_defaultyn");
            }
            else
            {
                radbtn_id=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_defaultyn");
            }
            if(radbtn_id.checked)
            {
                Flag = true;
            }
        }
        if(!Flag)
        {
            alert("Plz Select Default Company");
            return false;
        }    
    }
}
</script>
<div style="text-align: center; width: 10.0in">
    <table cellspacing="1" class="boxbg" width="800">
        <tr class="bgbluegrey">
            <td align="center">
                <strong>Mapping With Location</strong>
            </td>
        </tr>
    </table>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
                <tr style="background-color: White"> 
                    <td width="20%">
                        &nbsp;<asp:Label ID="lblEmpcode" style="text-align:left" runat="server" Text="Location Code"></asp:Label>
                    </td>
                    <td style="text-align :left; width: 163px;">
                        &nbsp;<asp:TextBox ID="txtLocCode" CssClass="blackfnt" runat="server" BorderStyle="Groove" Width="100px" style="text-align:left;" onblur="javascript:this.value=this.value.toUpperCase()" MaxLength="10"></asp:TextBox>
                        &nbsp;<input id="btnLocCode"  nowrap  type="button" value="..." runat="server" />
                    </td>
                    <td colspan="2" style="text-align :left; width: 160px;">
                        &nbsp;<asp:Button ID="btnLocSubmit" runat="server" OnClientClick="javascript:return CheckLocData()" OnClick="btnLocSubmit_Click" BorderStyle="Groove" CssClass="blackfnt" Text="Submit"/>
                    </td>
                </tr>
                <tr id="trgridview" runat="server" style="background-color: White" visible="false"> 
                    <td colspan="4">
                        <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" BorderWidth="0" ID="grvcontrols"
                        Width="100%" HeaderStyle-CssClass="bgbluegrey" HeaderStyle-HorizontalAlign="Center"
                        FooterStyle-CssClass="boxbg" AutoGenerateColumns="false"
                        EmptyDataText="No Records Found..."
                        OnRowDataBound="grvcontrols_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Company Code">
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="left" Width="20%"/>
                                <ItemTemplate>
                                    <asp:Label ID="lblcmpcode" Text='<%# DataBinder.Eval(Container.DataItem,"COMPANY_CODE") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Company Name">
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="left" Width="60%"/>
                                <ItemTemplate>
                                    <asp:Label ID="lblcmpname" Text='<%# DataBinder.Eval(Container.DataItem,"COMPANY_NAME") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Check Y/N">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" Width="10%"/>
                                <ItemTemplate>
                                    <asp:CheckBox ID="checkyn" runat="server"/>
                                    <asp:HiddenField ID="hdncheckyn" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"CHECKYN") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Default Y/N">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" Width="10%"/>
                                <ItemTemplate>
                                    <asp:RadioButton ID="defaultyn" runat="server" onclick="javascript:radio_btn_selection(this)"/>
                                    <asp:HiddenField ID="hdndefaultyn" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"DEFAULTYN") %>' />
                                    <%--<input type="radio" id="defaultyn" runat="server" onclick="radio_btn_selection(this)" />  --%>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr id="tractive" runat="server" style="background-color: White" visible="false"> 
                    <td>
                        &nbsp;<asp:Label ID="lblActive" style="text-align:left" runat="server" Text="Active"></asp:Label>
                    </td>
                    <td colspan="3" style="text-align:left">
                        &nbsp;<asp:CheckBox ID="chkActive" runat="server" />
                        <asp:HiddenField ID="HdnInsUpFlag" runat="server" />
                    </td>
                </tr>
                <tr id="trsubmit" class="bgbluegrey" runat="server" visible="false">
                    <td colspan="4" align="center">
                        <asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return CheckData();" BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT"
                            Width="150px" OnClick="btnSubmit_Click"/>
                        <asp:HiddenField ID="HiddenField1" runat="server" Value="0" /> 
                    </td> 
                </tr>    
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>    
</div>
</asp:Content>

