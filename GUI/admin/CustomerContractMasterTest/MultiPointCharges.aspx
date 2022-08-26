<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="MultiPointCharges.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_MultiPointCharges" %>

<asp:Content ID="cntone" runat="server" ContentPlaceHolderID="MyCPH1">

<script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>
<script type="text/javascript" language="javascript" >

function submitClick()
{
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    if(hdnajaxstate.value!="0")
    {
        alert("Let the Internal processes over. Try after 5-10 seconds later.");
        return false;
    }
    
    
    var grid=document.getElementById("ctl00_MyCPH1_grvmultipoint");
    var len=grid.rows.length;
    var pref="";
    var cnt=0;
    for(var i=2;i<len+1;i++)
    {
        
        if(i<10)
            pref="ctl00_MyCPH1_grvmultipoint_ctl0" + i + "_";
        else
            pref="ctl00_MyCPH1_grvmultipoint_ctl" + i + "_";
            
        var chkyes=document.getElementById(pref + "chkyes");
        if(chkyes.checked==true)
        {
            var txtfrom=document.getElementById(pref + "txtfrom");
            var txtto=document.getElementById(pref + "txtto");
            var cmbftltype=document.getElementById(pref + "cmbftltype");
            var cmbratetype=document.getElementById(pref + "cmbratetype");
            var txtpickup=document.getElementById(pref + "txtpickup");
            var txtdelivery=document.getElementById(pref + "txtdelivery");
            
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

  
            if(txtpickup.value=="")
                txtpickup.value="0.00";
                
            if(txtdelivery.value=="")
                txtdelivery.value="0.00";
                
            if(cmbratetype.value=="0" || cmbratetype.value=="0")
            {
                alert("Please Select Rate Type..........");
                cmbratetype.focus();
                return false;
            }


                var Jpref="";
                for(var j=2;j<len+1;j++)
                {
                    if(j<10)
                        Jpref="ctl00_MyCPH1_grvmultipoint_ctl0" + j + "_";
                    else
                        Jpref="ctl00_MyCPH1_grvmultipoint_ctl" + j + "_";
            
                     var chkJyes=document.getElementById(Jpref + "chkyes");
                     var txtJfrom=document.getElementById(Jpref + "txtfrom");
                     var txtJto=document.getElementById(Jpref + "txtto");
                     var cmbJftltype=document.getElementById(Jpref + "cmbftltype");
                     
                     if(i!=j)
                     {
                        if(txtfrom.value==txtJfrom.value && txtto.value==txtJto.value && cmbftltype.value==cmbJftltype.value && chkJyes.checked==true)
                        {
                            alert("No two location pairs shold be same");
                            txtfrom.focus();
                            return false;
                        }
                     }
                }
        }
    }
    
    if(cnt==0)
    {
        alert("Please Select atleast one Row..");
        return false;
    }
    return true;
}

function addRows()
{
    var txtnorows=document.getElementById("ctl00_MyCPH1_txtnorows");
    if(txtnorows.value=="")
    {
        alert("Please Enter No of Rows");
        txtnorows.focus();
        return false;
    }
    
    if(isNaN(txtnorows.value))
    {
        alert("Please Enter Numeric Data");
        txtnorows.focus();
        return false;
    }
return true;
}


function locTest(id)
{
   
    var txtloc=document.getElementById(id);
    txtloc.value=txtloc.value.toUpperCase();

    if(txtloc.value=="")
        return false;

    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    hdnajaxstate.value="1";
    
    var ajaxobj=false;
    ajaxobj=GetXMLHttpObject();
    if(ajaxobj)
    {
     var strpg="AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txtloc.value + "&sid=" + Math.random() + "&sid=" + Math.random();
     ajaxobj.open("GET",strpg);
     ajaxobj.onreadystatechange=function()
         {
             if((ajaxobj.readyState==4) && (ajaxobj.status==200))
                {
                  var  res=ajaxobj.responseText.split("|");
                  
                  if(res[0]=="false")
                     {
                        alert(txtloc.value + " Locaton doesn't Exists");
                        txtloc.value="";
                        txtloc.focus();
                        hdnajaxstate.value="0";
                        return false;
                     }
                  else
                        hdnajaxstate.value="0";
                }
         }
         
    ajaxobj.send(null);
    }
    
return false;
}

// USED TO ENTER BRANCH,LOCATION OR ZONE VIA POPUP
function popuplist(mode,ctlid,tbl)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=0";
            confirmWin=window.open(url,"",winOpts);
            return false;
 }

// USED TO ENTER BRANCH,LOCATION OR ZONE VIA POPUP IN HEADER ALSO
function popuplisthead(mode,ctlid,tbl,head)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=" + head ;
            confirmWin=window.open(url,"",winOpts);
            return false;
 }
</script>

    <br />
    <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%;
                            left: 40%;" width="190px" cellpadding="0"
                        bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
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
    <br />
    <asp:UpdatePanel runat="server" ID="updone">
        <ContentTemplate>
            <asp:Panel ID="divmain" runat="server" Width="10in">
                <asp:Table ID="tblmain" CssClass="boxbg" BorderWidth="0" CellSpacing="1" runat="server" Width="100%">
                    <asp:TableRow runat="server" CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="2">Multi-Point PickUp/Delivery Charges</asp:TableCell>
                    </asp:TableRow>
                     <asp:TableRow runat="server" BackColor="White">
                        <asp:TableCell HorizontalAlign="Right" Width="50%">
                            Enter No of Rows
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtnorows" Width="50px" style="text-align:right;" onkeypress="javascript:return validInt(event)" BorderStyle="Groove" MaxLength="3" runat="server"></asp:TextBox>
                            <asp:Button ID="btnaddrows" runat="server" Text="Add Rows" OnClientClick="javascript:return addRows()" CssClass="blackfnt" OnClick="btnaddrows_Click" />
                        </asp:TableCell>
                     </asp:TableRow>
                    <asp:TableRow runat="server" BackColor="White">
                        <asp:TableCell ColumnSpan="2">
                            <asp:GridView CssClass="boxbg" runat="server" ID="grvmultipoint" CellSpacing="1"
                                Width="100%" AllowSorting="true" BorderWidth="0" PagerSettings-Mode="NumericFirstLast"
                                 AutoGenerateColumns="false" OnRowDataBound="grvmultipoint_RowDataBound">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <input type="button" id="btnheadfrom" onclick="javascript:return popuplisthead('branch','txtfrom','grvmultipoint','4row')"  value="...." class="blackfnt" runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" 
                                                Width="50px" BorderStyle="Groove" MaxLength="10" Text='<%# DataBinder.Eval(Container.DataItem,"from_loc") %>'
                                                 onblur="javascript:return locTest(this.getAttribute('id'))" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" onclick="javascript:return popuplist('branch',this.getAttribute('id'),'none')" value="...." class="blackfnt" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <input type="button" id="btnheadto" value="...." onclick="javascript:return popuplisthead('branch','txtto','grvmultipoint','4row')"  class="blackfnt" runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Width="50px" MaxLength="10" Text='<%# DataBinder.Eval(Container.DataItem,"to_loc") %>'
                                            onblur="javascript:return locTest(this.getAttribute('id'))" BorderStyle="Groove" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" value="...." class="blackfnt" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbftltype" DataTextField="codedesc" DataValueField="codeid" runat="server" CssClass="blackfnt" BackColor="white">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype" runat="server" CssClass="blackfnt" BackColor="white">
                                            <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                            <asp:ListItem Value="W" Text="PerKG"></asp:ListItem>
                                            <asp:ListItem Value="P" Text="PerPKG"></asp:ListItem>
                                            <asp:ListItem Value="T" Text="PerTon"></asp:ListItem>
                                            <asp:ListItem Value="F" Text="Flat"></asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            PickUp
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtpickup" Style="text-align: right;" Text='<%# DataBinder.Eval(Container.DataItem,"pickup_chrg") %>'
                                             onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                              onblur="javascript:return this.value=roundNumber(this.value,2)"  Width="100px" BorderStyle="Groove" MaxLength="15" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Delivery
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtdelivery" Style="text-align: right;" Text='<%# DataBinder.Eval(Container.DataItem,"delivery_chrg") %>'
                                             onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                               onblur="javascript:return this.value=roundNumber(this.value,2)" Width="100px" BorderStyle="Groove" MaxLength="15" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow runat="server" CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                            <asp:Button ID="btnsubmit" OnClientClick="javascript:return submitClick()"
                             OnClick="btnsubmit_Click" runat="server" CssClass="blackfnt" Text="Submit" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
