<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReassignPartyCodenBillingLocation.aspx.cs"
    MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_Finance_Billing_Bill_Edit_ReassignPartyCodenBillingLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script type="text/javascript" language="javascript" src="../../Accounts/AJAX.js"></script>
<script type="text/javascript" language="javascript" src="../../../images/CalendarPopup.js"></script>
<script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
<script type="text/javascript" language="javascript">

function locBlur(id)
{
    //debugger;
    var txt=document.getElementById(id);
    
     if(txt.value=="")
        return false;
    txt.value=txt.value.toUpperCase();
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=loc&code=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                       var res=findobj.responseText.split("|");
                       if(res[0]=="false")
                       {
                            alert("Location Is not Valid..Enter Proper Location Code....");
                            txt.value="";
                            txt.select();
                            return false;
                       }
                }
          }
      findobj.send(null);
    }
}

function partyBlur(id)
{
    var txt=document.getElementById(id);
    if(txt.value=="")
        return false;
    txt.value=txt.value.toUpperCase();
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=party&code=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                       var res=responseText.split("|");
                       if(res[0]=="false")
                       {
                            alert("Party Code Is not Valid..Enter Proper Party Code....");
                            txt.value="";
                            txt.select();
                            return false;
                       }
                }
          }
      findobj.send(null);
    }
}

function validateBoxes()
{
   //debugger;
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   var non=0;
   for(var i=2;i<=r;i++)
   {
        //ctl00$MyCPH1$grvcontrols$ctl03$txtpartycode
        var txtdocno,txtpartycode,txtlocation;
        if(i<10)
            {
                txtdocno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtbillnumber");
                //txtpartycode=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtpartycode");
                txtlocation=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtlocation");
            }
        else
            {
                txtdocno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtbillnumber");
                //txtpartycode=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtpartycode");
                txtlocation=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtlocation");
            }
            
            if(txtdocno.value!="")
                {
                    non=1;
//                    if(txtpartycode.value=="")
//                    {
//                        alert("Enter Party Code Proprly.....");
//                        txtpartycode.focus();
//                        return false;
//                    }
                    if(txtlocation.value=="")
                    {
                        alert("Enter Location Proprly.....");
                        txtlocation.focus();
                        return false;
                    }
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

function docBlur(id)
{
    //debugger;
    var str="";
    for(var i=0;i<id.length-13;i++)
    {
        str+=id.charAt(i);
    }
   
    
    var txtdocno=document.getElementById(id);
//    var str1=str + "txtexpartycode";
//    var txtpartycode=document.getElementById(str1);
    var txtlocation=document.getElementById(str + "txtexlocation");
    
    var docno=txtdocno.value;
    if(docno=="")
    {
        return false;
    }
 
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   //debugger;
   for(var i=2;i<=r;i++)
   {
        //ctl00$MyCPH1$grvcontrols$ctl03$txtpartycode
        var txtno, txtdocno;
        if(i<10)
            txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtbillnumber");
        else
            txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtbillnumber");

        for(var j=i+1 ; j<=r; j++)
        {
            if(j<10)
                txtdocno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + j + "$txtbillnumber");
            else
                txtdocno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + j + "$txtbillnumber");
             
             if(txtdocno.value != "" && txtno.value != "")
               {
//                    if(txtdocno.getAttribute('id')!= txtno.getAttribute('id'))
//                    {
                      if(txtdocno.value == txtno.value)
                      {  
                        alert("Duplicate Document Number....Enter another Document Number....");
                        txtdocno.value="";
                        txtdocno.focus();
                        return false;
                      }
               }
        }   
 
    }
    
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="BringDocDetails.aspx?mode=doc&docno=" + docno + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
          
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert(res[1]);
                        txtdocno.value="";
                        txtdocno.focus();
                        return false;
                    }
                    //txtpartycode.value=res[1];
                    txtlocation.value=res[2];
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
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            width="100%">
            <tr class="bgbluegrey">
                <td class="blackfnt" align="center">
                    <b>Re-Assign Billing Location</b></td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="45%" align="center">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="left" width="50%">
                            Enter No. of Rows</td>
                        <td class="blackfnt" align="left" width="50%">
                            <asp:TextBox runat="server" MaxLength="2" BorderStyle="groove" Style="text-align: right;"
                                CssClass="blackfnt" onkeypress="javascript:validInt(event);" Width="60px" ID="txtnorows"></asp:TextBox>
                            <asp:Button runat="server" Text="Add Rows" OnClick="btnrows_Click" ID="btnrows" CssClass="blackfnt" />
                        </td>
                    </tr>
                </table>
                <br />
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="100%">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="left">
                            <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" ID="grvcontrols" AllowPaging="false"
                                Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="true"
                                PagerSettings-FirstPageText="[First]" BorderWidth="0" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                                OnRowDataBound="grvcontrols_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr. No.">
                                        <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" Width="10%" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Document Number" >
                                        <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" Width="40%"/>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtbillnumber" Width="100px" BorderStyle="Groove" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Exitsting Party Code">
                                        <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexpartycode" CssClass="blackfnt" MaxLength="5" Width="100px" BorderStyle="Groove" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Party Code<br />
                                            <asp:Button ID="btnheadpartycode" CssClass="blackfnt" Text="..." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox Enabled="true" ID="txtpartycode" CssClass="blackfnt" MaxLength="5" BorderStyle="Groove" Width="100px" runat="server"></asp:TextBox>
                                            <asp:Button ID="btnpartycode" Text="..." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Bill Location">
                                        <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" Width="25%" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexlocation" CssClass="blackfnt" MaxLength="5" Width="60px" BorderStyle="Groove" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="New Bill Location">
                                        <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" Width="25%" />
                                        <HeaderTemplate>
                                            New Bill Location<br />
                                            <asp:Button ID="btnallloc" CssClass="blackfnt" Text="..." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtlocation" CssClass="blackfnt" MaxLength="5" Width="60px" BorderStyle="Groove" runat="server"></asp:TextBox>
                                            <asp:Button ID="btnlocation" Text="..." CssClass="blackfnt" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td class="blackfnt" align="center">
                            <asp:Button runat="server" OnClick="btnsubmit_Click" CssClass="blackfnt" Text="Submit" ID="btnsubmit"></asp:Button>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:HiddenField ID="hdnrows" runat="server" Value="5" />
</asp:Content>
