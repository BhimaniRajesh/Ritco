<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FTLFreightMatrix.aspx.cs" Inherits="GUI_AllTest_NewFTL" Title="Untitled Page" %>

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

    
function windowHeadPopUp(mode,ctlid,tbl,head)
{
     var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=" + head ;
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
        var hdnajaxstate =  document.getElementById("ctl00_MyCPH1_hdnajaxstate");
        var grid =  document.getElementById("ctl00_MyCPH1_grvcharges");
        var len=parseInt(grid.rows.length);
        var pref="";
        var cnt=0;
       
        var ddlratetype=document.getElementById("ctl00_MyCPH1_ddlratetype");
        
        if(ddlratetype.value=="0" || ddlratetype.value=="" )
        {
            alert("Please Select Rate Type...");
            ddlratetype.focus();
            return false;
        }
       
        if(!checkFTLDuplicy())
            return false;
            
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
                
                var txtrate1=document.getElementById(pref+"txtrate1");
                var txttrdays1=document.getElementById(pref+"txttrdays1");
                var txtrate2=document.getElementById(pref+"txtrate2");
                var txttrdays2=document.getElementById(pref+"txttrdays2");
                var txtrate3=document.getElementById(pref+"txtrate3");
                var txttrdays3=document.getElementById(pref+"txttrdays3");
                var txtrate4=document.getElementById(pref+"txtrate4");
                var txttrdays4=document.getElementById(pref+"txttrdays4");
                var txtrate5=document.getElementById(pref+"txtrate5");
                var txttrdays5=document.getElementById(pref+"txttrdays5");
                var txtrate6=document.getElementById(pref+"txtrate6");
                var txttrdays6=document.getElementById(pref+"txttrdays6");
                var txtrate7=document.getElementById(pref+"txtrate7");
                var txttrdays7=document.getElementById(pref+"txttrdays7");
                var txtrate8=document.getElementById(pref+"txtrate8");
                var txttrdays8=document.getElementById(pref+"txttrdays8");
                var txtrate9=document.getElementById(pref+"txtrate9");
                var txttrdays9=document.getElementById(pref+"txttrdays9");
                var txtrate10=document.getElementById(pref+"txtrate10");
                var txttrdays10=document.getElementById(pref+"txttrdays10");      
                
                
                if(txtrate1.value=="") txtrate1.value="0.00";
                if(txtrate2.value=="") txtrate2.value="0.00";
                if(txtrate3.value=="") txtrate3.value="0.00";
                if(txtrate4.value=="") txtrate4.value="0.00";
                if(txtrate5.value=="") txtrate5.value="0.00";
                if(txtrate6.value=="") txtrate6.value="0.00";
                if(txtrate7.value=="") txtrate7.value="0.00";
                if(txtrate8.value=="") txtrate8.value="0.00";
                if(txtrate9.value=="") txtrate9.value="0.00";
                if(txtrate10.value=="") txtrate10.value="0.00";
                
                if(txttrdays1.value=="") txttrdays1.value="0";
                if(txttrdays2.value=="") txttrdays2.value="0";
                if(txttrdays3.value=="") txttrdays3.value="0";
                if(txttrdays4.value=="") txttrdays4.value="0";
                if(txttrdays5.value=="") txttrdays5.value="0";
                if(txttrdays6.value=="") txttrdays6.value="0";
                if(txttrdays7.value=="") txttrdays7.value="0";
                if(txttrdays8.value=="") txttrdays8.value="0";
                if(txttrdays9.value=="") txttrdays9.value="0";
                if(txttrdays10.value=="")txttrdays10.value="0";            
            
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
                    
                    if(i!=j && chkjyes.checked==true)
                    {
                        if(txtfrom.value==txtjfrom.value && txtto.value==txtjto.value)
                        {
                            alert("No Two  pair should be same.Please Enter Another Location");
                            txtto.value="";
                            txtto.focus();
                            return false;
                        }
                        
                    } // i!=j
                    
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
    
    
    function checkFTLDuplicy()
    {
        var grid =  document.getElementById("ctl00_MyCPH1_grvcharges");
        
        for(var i=1;i<11;i++)
        {
            var cmbIftltype = document.getElementById("ctl00_MyCPH1_grvcharges_ctl01_cmbftltype" + i);
            for(var j=1;j<10;j++)
            {
                var cmbJftltype = document.getElementById("ctl00_MyCPH1_grvcharges_ctl01_cmbftltype" + j);
                
                if(cmbIftltype.value!="0" && cmbJftltype.value!="0")
                {
                    if(i!=j && cmbJftltype.value==cmbIftltype.value)
                    {
                        alert("No Two FTL types should be same");
                        cmbJftltype.focus();
                        return false;
                    }
                }
            }
        }
        return true;
    }
    
    
    </script>

    <br />
    <asp:Table ID="Table2" runat="server" CssClass="blackfnt">
        <asp:TableRow BackColor="White">
            <asp:TableCell>
				       &nbsp;ContractID  
            </asp:TableCell>
            <asp:TableCell>
                :
                <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'"
                    CssClass="redfnt" Font-Bold="true"></asp:Label>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow BackColor="White">
            <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
            </asp:TableCell>
            <asp:TableCell>
                :
                <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'"
                    CssClass="blackfnt" Font-Bold="true"></asp:Label>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <br />
    <asp:UpdatePanel ID="upone" runat="server">
        <ContentTemplate>
            <asp:UpdatePanel runat="server" ID="updone">
                <ContentTemplate>
                    <asp:Table runat="server">
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
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">From Location Filter
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblfilterfrom" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">To Location Filter
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
                                        <asp:TableCell ColumnSpan="2" Font-Bold="true">
                                       FTL SLAB Rate Type
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:DropDownList ID="ddlratetype" runat="server" CssClass="blackfnt" BackColor="white">
                                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="PerKG" Value="W"></asp:ListItem>
                                                <asp:ListItem Text="PerPKG" Value="P"></asp:ListItem>
                                                <asp:ListItem Text="PerTon" Value="T"></asp:ListItem>
                                                <asp:ListItem Text="Flat(in RS)" Value="F"></asp:ListItem>
                                            </asp:DropDownList>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgbluegrey">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:Label ID="lblheader" CssClass="blackfnt" Font-Bold="true" runat="server" Text="FTL SLAB Rates"></asp:Label>
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
                                                                        <input type="button" id="btnfrom" runat="server" class="blackfnt" value="...." />
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
                                                    <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderTemplate>
                                                            <asp:DropDownList ID="cmbftltype1" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                                                CssClass="blackfnt" BackColor="white">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate1" Width="70px" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                Text='<%# DataBinder.Eval( Container.DataItem,"rate1") %>' BorderStyle="Groove"
                                                                onblur="javascript:return this.value=roundNumber(this.value,2)" MaxLength="9"
                                                                CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays1" Width="40px" Style="text-align: right;" onkeypress="javascript:return validInt(event)"
                                                                Text='<%# DataBinder.Eval( Container.DataItem,"trdays1") %>' BorderStyle="Groove"
                                                                MaxLength="3" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderTemplate>
                                                            <asp:DropDownList ID="cmbftltype2" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                                                CssClass="blackfnt" BackColor="white">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate2" Width="70px" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"rate2 ") %>'
                                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" BorderStyle="Groove"
                                                                onblur="javascript:return this.value=roundNumber(this.value,2)" MaxLength="9"
                                                                CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays2" Width="40px" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"trdays2") %>'
                                                                onkeypress="javascript:return validInt(event)" BorderStyle="Groove" MaxLength="3"
                                                                CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderTemplate>
                                                            <asp:DropDownList ID="cmbftltype3" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                                                CssClass="blackfnt" BackColor="white">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate3" Width="70px" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                Text='<%# DataBinder.Eval( Container.DataItem,"rate3") %>' BorderStyle="Groove"
                                                                onblur="javascript:return this.value=roundNumber(this.value,2)" MaxLength="9"
                                                                CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays3" Width="40px" Text='<%# DataBinder.Eval( Container.DataItem,"trdays3") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" BorderStyle="Groove"
                                                                MaxLength="3" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderTemplate>
                                                            <asp:DropDownList ID="cmbftltype4" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                                                CssClass="blackfnt" BackColor="white">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate4" Width="70px" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                Text='<%# DataBinder.Eval( Container.DataItem,"rate4") %>' BorderStyle="Groove"
                                                                onblur="javascript:return this.value=roundNumber(this.value,2)" MaxLength="9"
                                                                CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays4" Width="40px" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"trdays4") %>'
                                                                onkeypress="javascript:return validInt(event)" BorderStyle="Groove" MaxLength="3"
                                                                CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderTemplate>
                                                            <asp:DropDownList ID="cmbftltype5" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                                                CssClass="blackfnt" BackColor="white">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate5" Width="70px" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                Text='<%# DataBinder.Eval( Container.DataItem,"rate5") %>' BorderStyle="Groove"
                                                                onblur="javascript:return this.value=roundNumber(this.value,2)" MaxLength="9"
                                                                CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays5" Width="40px" Text='<%# DataBinder.Eval( Container.DataItem,"trdays5") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" BorderStyle="Groove"
                                                                MaxLength="5" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderTemplate>
                                                            <asp:DropDownList ID="cmbftltype6" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                                                CssClass="blackfnt" BackColor="white">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate6" Width="70px" Text='<%# DataBinder.Eval( Container.DataItem,"rate6") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                BorderStyle="Groove" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                                MaxLength="9" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays6" Width="40px" Text='<%# DataBinder.Eval( Container.DataItem,"trdays6") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" BorderStyle="Groove"
                                                                MaxLength="3" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderTemplate>
                                                            <asp:DropDownList ID="cmbftltype7" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                                                CssClass="blackfnt" BackColor="white">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate7" Width="70px" Text='<%# DataBinder.Eval( Container.DataItem,"rate7") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                BorderStyle="Groove" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                                MaxLength="9" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays7" Width="40px" Text='<%# DataBinder.Eval( Container.DataItem,"trdays7") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" BorderStyle="Groove"
                                                                MaxLength="3" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderTemplate>
                                                            <asp:DropDownList ID="cmbftltype8" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                                                CssClass="blackfnt" BackColor="white">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate8" Width="70px" Text='<%# DataBinder.Eval( Container.DataItem,"rate8") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                BorderStyle="Groove" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                                MaxLength="9" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays8" Width="40px" Text='<%# DataBinder.Eval( Container.DataItem,"trdays8") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" BorderStyle="Groove"
                                                                MaxLength="3" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderTemplate>
                                                            <asp:DropDownList ID="cmbftltype9" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                                                CssClass="blackfnt" BackColor="white">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate9" Width="70px" Text='<%# DataBinder.Eval( Container.DataItem,"rate9") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                BorderStyle="Groove" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                                MaxLength="9" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays9" Width="40px" Text='<%# DataBinder.Eval( Container.DataItem,"trdays9") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" BorderStyle="Groove"
                                                                MaxLength="3" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderTemplate>
                                                            <asp:DropDownList ID="cmbftltype10" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                                                CssClass="blackfnt" BackColor="white">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate10" Width="70px" Text='<%# DataBinder.Eval( Container.DataItem,"rate10") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                BorderStyle="Groove" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                                MaxLength="9" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays10" Width="40px" Text='<%# DataBinder.Eval( Container.DataItem,"trdays10") %>'
                                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" BorderStyle="Groove"
                                                                MaxLength="3" CssClass="blackfnt" runat="server"></asp:TextBox>
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
                    <asp:HiddenField ID="hdnftls" runat="server" />
                    <asp:HiddenField ID="hdncontracttype" runat="server" />
                    <asp:HiddenField ID="hdncontractid" runat="server" />
                    <asp:HiddenField ID="hdncustcode" runat="server" />
                    <asp:HiddenField ID="hdnmatrixtype" runat="server" />
                    <asp:HiddenField ID="hdntransmode" runat="server" />
                    <asp:HiddenField ID="hdntransname" runat="server" />
                    <asp:HiddenField ID="hdnajaxstate" runat="server" />
                    <asp:HiddenField ID="hdnfrom" runat="server" />
                    <asp:HiddenField ID="hdnto" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
