<%@ Control Language="C#" AutoEventWireup="true" CodeFile="XAC.ascx.cs" Inherits="GUI_Operation_DocketEntry_XAC" %>
<script type="text/javascript" language="javascript">
// Declaration



// JScript File
function xacKeyDown(e,WEBX)
{
        WEBX.WebxComplete.div.style.position='absolute';
        var code;if (!e) var e = window.event;if (e.keyCode)code = e.keyCode;else if (e.which) code = e.which; else return true;
     
        if(code==40)
        {
            var i=parseInt(document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            var cval_pre =  document.getElementById('tcd'+i);
            i++;
            var cval_nex =  document.getElementById('tcd'+i);
            
            if(cval_pre && cval_nex)
            {
                cval_nex.style.color='black'; 
                cval_nex.setAttribute("font-weight","normal");
                cval_pre.style.fontWeight='normal';
                cval_pre.setAttribute("bgColor","#FFFFFF");
                cval_pre.style.color='black';
            }
            if(cval_nex)
            {
                document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value=i;
                cval_nex.setAttribute("font-weight","bold");
                cval_nex.style.fontWeight='bold';
                cval_nex.setAttribute("bgColor","yellow");
            }
        }
        else if(code==38)
        {
            var i=parseInt(document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            var cval_pre=  document.getElementById('tcd'+i);
            i--;
            var cval_nex=  document.getElementById('tcd'+i);
            if(cval_pre && cval_nex)
            {
                cval_nex.style.color='black'; document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value=i;
                cval_nex.setAttribute("font-weight","normal");
                cval_pre.style.fontWeight='normal';
                cval_pre.setAttribute("bgColor","#FFFFFF");
                cval_pre.style.color='black';
            }
            if(cval_nex)
            {
                cval_nex.setAttribute("font-weight","bold");
                cval_nex.style.fontWeight='bold';
                cval_nex.setAttribute("bgColor","yellow");
            }
        }
        else if(code==27)
        {
            WEBX.WebxComplete.div.innerHTML='';
            WEBX.WebxComplete.div.style.display='none';
        }
        else if(code==9 || code==13)
        {
            var i=parseInt(document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            var cval=document.getElementById("cval" + document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            var nval=document.getElementById("nval" + document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value);
            if(cval)WEBX.WebxComplete.Target1.value=cval.innerText;
            if(nval && WEBX.WebxComplete.Target2)WEBX.WebxComplete.Target2.value=nval.innerText;
            WEBX.WebxComplete.div.innerHTML='';
            WEBX.WebxComplete.div.style.display='none';
            WEBX.WebxComplete.Target1.focus();
                event.returnValue=false;
                event.cancel = true;
        }
        else
        {
            event.returnValue=false;
            event.cancel = true;
        }
   return false;
}


function CodeKeyUp(e,WEBX,init)
{
        WEBX.WebxComplete.div.style.position='absolute';WEBX.WebxComplete.div.width='300px';
        WEBX.WebxComplete.Target1.autocomplete='off';
        var code;if (!e) var e = window.event;if (e.keyCode)code = e.keyCode;else if (e.which) code = e.which; else return true;
        if(code==8 || code==46)
        { 
            if(parseInt(WEBX.WebxComplete.Target1.value.length)<WEBX.WebxComplete.preflen+2) 
            { 
                WEBX.WebxComplete.div.innerHTML='';
                WEBX.WebxComplete.div.style.display='none';
                return false;
            }
        } 
        else 
        { 
            if(parseInt(WEBX.WebxComplete.Target1.value.length)<WEBX.WebxComplete.preflen)
            { 
                WEBX.WebxComplete.div.innerHTML='';WEBX.WebxComplete.div.style.display='none';
                return false;
            } 
        }
       
        if(code==40)        
        {
            if(WEBX.WebxComplete.div.style.display=='none')return false;
            WEBX.WebxComplete.div.focus();
            WEBX.WebxComplete.fs_st.value="1";
            document.getElementById(WEBX.WebxComplete.ino.getAttribute('id')).value="1";
            var cval_nex =  document.getElementById('tcd1');
            if(cval_nex)
            {
                cval_nex.setAttribute("font-weight","bold");
                cval_nex.style.fontWeight='bold';
                cval_nex.setAttribute("bgColor","yellow");
            }
            
        }
        else if(code==38 || code==37 || code==39 || code == 13){ event.returnValue=false; event.cancel = true;}
        else if(code==9)
        {
            WEBX.WebxComplete.div.style.display='none';
            WEBX.WebxComplete.div.innerHTML='';
        }
        else
        {   
            var findobj=false;
            findobj=GetXMLHttpObject();
            if(findobj)
            {
                var fileURL = new String(document.location)
                var cnt=fileURL.indexOf("/GUI/",0);
              var strpg= fileURL.substring(0,cnt) + '/GUI/Common_UserControls/WebxComplete/_xac_data.aspx?tp='+ WEBX.WebxComplete.Type + '&target1=' + WEBX.WebxComplete.Target1.getAttribute('id');
              if(WEBX.WebxComplete.Target2)
                strpg = strpg + '&target2=' + WEBX.WebxComplete.Target2.getAttribute('id');
              else
                strpg = strpg + '&target2=';
             strpg = strpg + '&code1='+ WEBX.WebxComplete.Target1.value;
             if(WEBX.WebxComplete.filt1)
                strpg = strpg + "&filt1=" + WEBX.WebxComplete.filt1.value;
             else
                strpg = strpg + "&filt1=";
             strpg = strpg + "&filt2=" + WEBX.WebxComplete.filt2.value;
             strpg = strpg + '&sid=' + Math.random() + '&sid=' + Math.random();
             findobj.open('GET',strpg);
             
             findobj.onreadystatechange=function()
                 {
                     if((findobj.readyState==4) && (findobj.status==200))
                        {
                          WEBX.WebxComplete.div.innerHTML='';
                            if(init.value=="0")
                                return;
                          
                          WEBX.WebxComplete.div.innerHTML= findobj.responseText;
                          WEBX.WebxComplete.div.style.display='block';
                          var ht="";
                          ht=document.getElementById("tblmain").offsetHeight;
                          if(ht=="")ht="0";
                          
                          if(parseInt(ht)>10)WEBX.WebxComplete.div.style.display='block'; else WEBX.WebxComplete.div.style.display='none';         
                                  
                          if(parseInt(ht)<300)
                              WEBX.WebxComplete.div.style.height=document.getElementById("tblmain").style.height;
                          else
                              WEBX.WebxComplete.div.style.height="200px";
                        }
                 }
             findobj.send(null);
            }
        }
        
}

function CodeBlur(fs_st, div,ino,target,init)
{
    if(fs_st.value=="0")
    {
        var ino = document.getElementById(fs_st.getAttribute('id').substring(0,parseInt(fs_st.getAttribute('id').length)-5)+'ino');
        var code=document.getElementById('tcd'+ino.value);
        div.innerHTML='';div.style.display='none';
        init.value="0";
    }   
    ino.value="1";target.value = target.value.toUpperCase();
}

function CodeFocus(fs_st, div,ino,target,init)
{
    init.value="1";
}

function xacMouseOver(fs_st,ms_fs)
{
    fs_st.value="1";   ms_fs.value='1';
}

function xacMouseOut(fs_st,ms_fs)
{
    fs_st.value="0";ms_fs.value='0';
}

function xacFocus(code)
{}

function xacBlur(e,div,ms_fs,ino)
{   
   if(ms_fs.value=='0')
   {
    div.style.display='none';
   }
}

function itemMouseOver(tr,cval)
{
   tr.setAttribute("font-weight","bold");
   tr.style.fontWeight='bold';
   tr.setAttribute("bgColor","yellow");
   tr.style.cursor='pointer';
}

function itemMouseOut(tr,cval)
{
   tr.setAttribute("font-weight","normal");
   tr.style.fontWeight='normal';
   tr.setAttribute("bgColor","white");
}
</script>
<asp:Panel ID="divXAC" style="position:absolute; width:300px;display:none; z-index:10000; cursor:pointer; scrollbar-base-color: #d4e0e7; scrollbar-3dlight-color: #d4e0e7;
                        scrollbar-highlight-color: #d4e0e7; scrollbar-shadow-color: #d4e0e7;" ScrollBars="Both" Width="2in" runat="server"></asp:Panel>
<asp:HiddenField ID="ino" Value="0" runat="server" />
<asp:HiddenField ID="c_id" Value="0" runat="server" />
<asp:HiddenField ID="fs_st" Value="0" runat="server" />
<asp:HiddenField ID="fltr_str" runat="server" />
<asp:HiddenField ID="init" Value="0" runat="server" />
<asp:HiddenField ID="ms_fs" Value="0" runat="server" />

