<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="ReAssignPayBase.aspx.cs" Inherits="GUI_Finance_Billing_BillEdit_ReAssignBillSumissionnCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script type="text/javascript" language="javascript" src="../../../../GUI/images/commonJs.js"></script>
<script type="text/javascript" language="javascript">


function validateBoxes()
{
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   var non=0;
   for(var i=2;i<r;i++)
   {
        //ctl00_MyCPH1_grvcontrols_ctl03_txtsubloc
        var txtdockno;
        if(i<10)
            {
                txtdockno=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtdockno");
               
            }
        else
            {
                txtdockno=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtdockno");
                
            }
            
            if(txtdockno.value!="")
                {
                    non=1;
                }
    } /// end for
    if(non==0)
    {
        alert("There is no Docket Number to Update.........");
        return false;
    }
}

function popuplist(mode,ctlid,tbl)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
            confirmWin=window.open(url,"",winOpts);
 }

function addRows()
{
    if(confirm("The Entered Data will be Removed. Are you want to continue...?"))
        return true;
    else
        return false;
}

function dockBlur(id)
{
    var str="";
    for(var i=0;i<id.length-9;i++)
    {
        str+=id.charAt(i);
    }
    
    var txtdockno=document.getElementById(id);
    txtdockno.value=txtdockno.value.toUpperCase();
    var str1=str + "lblexpaybas";
    var lblexpaybase=document.getElementById(str1);
    
    
    var dockno=txtdockno.value;
    if(dockno=="")
    {
        return false;
    }
 
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   
   for(var i=2;i<r;i++)
   {
        //ctl00_MyCPH1_grvcontrols_ctl03_txtsubloc
        var txtno;
        if(i<10)
            txtno=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtdockno");
        else
            txtdockno=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtdockno");

         if(txtdockno.value==txtno.value)
           {
                if(txtdockno.getAttribute('id')!=txtno.getAttribute('id'))
                {
                    alert("Duplicate Document Number....Enter another Document Number....");
                    txtdockno.value="";
                    txtdockno.select();
                    return false;
                }
           }
 
    }
    
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="BringDocDetails.aspx?mode=paybasedocketno&dockno=" + dockno + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
          
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert(res[1]);
                        txtdockno.value="";
                        txtdockno.select();
                        return false;
                    }
                }
         }
         
    findobj.send(null);
    }
    
    
    return false;
}

    </script>

    <div align="left" style="width: 10in;">
        <br />
        <br />
        <br /><br />
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            width="100%">
            <tr class="bgbluegrey">
                <td class="blackfnt" align="center"><b>
                    Re-Assign PayBase</b>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="100%">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="right" width="50%">
                            Enter No. of Rows </td>
                        <td class="blackfnt" align="left" width="50%">
                            <asp:TextBox runat="server" ID="txtnorows" Width="40px" style="text-align:right;" BorderStyle="Groove" MaxLength="2" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                            <asp:Button runat="server" Text="Add Rows" CssClass="blackfnt" OnClick="btnrows_Click" ID="btnrows" />
                        </td>
                    </tr>
                </table>
                <br />
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="100%">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="left">
                            <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" BorderWidth="0" ID="grvcontrols"
                                AllowPaging="true" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                                OnRowDataBound="grvcontrols_RowDataBound">
                                <Columns>
                                   <asp:TemplateField HeaderText="">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle Width="10px" CssClass="blackfnt" BackColor="white" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                    
                                    <asp:TemplateField HeaderText="Dcoket Number">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtdockno" runat="server" BorderStyle="Groove" MaxLength="25" Width="100px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Existing PayBase">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblexpaybas" runat="server" CssClass="blackfnt"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            New PayBase
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbnewpaybase" runat="server" CssClass="blackfnt">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="P01">Paid</asp:ListItem>
                                                <asp:ListItem Value="P02">TBB</asp:ListItem>
                                                <asp:ListItem Value="P03">To Pay</asp:ListItem>
                                                <asp:ListItem Value="P07">FOC</asp:ListItem>
                                                <asp:ListItem Value="P08">BOD</asp:ListItem>
                                                <asp:ListItem Value="P09">National</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                     <asp:TemplateField HeaderText="Existing PayBase">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                           <asp:TextBox ID="txtpartycode" runat="server" BorderStyle="Groove" MaxLength="25" Width="100px"></asp:TextBox>
                                           <input type="button" class="blackfnt" value="..." />
                                           <asp:TextBox ID="txtpartyname" runat="server" BorderWidth="0" Enabled="false" BorderStyle="Groove" MaxLength="25" Width="100px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td class="blackfnt" align="center">
                            <asp:Button runat="server" OnClick="btnsubmit_Click" Text="Submit" CssClass="blackfnt"
                                ID="btnsubmit"></asp:Button>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:HiddenField ID="hdnrows" runat="server" Value="5" />
</asp:Content>
