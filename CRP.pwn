//---------------------(Curitiba Rp)------------------------//
/* Gm Feita Por Ale Para Demostracao de prestacao de servico*/



//---------------------(Includes)------------------------//
#include <a_samp>
#include <DOF2>
#include <sscanf>
#include <zcmd>
//---------------------(Defines)------------------------//
#define dr 0
#define dl 1
#define dg 2
#define da 3
#define daa1 4
#define daa2 5
#define daa3 6
#define daa4 7
#define daa5 8
#define dp 9
#define Contas "Contas/%s.ini"
//---------------------(pInfo)------------------------//
enum pInfo
{
   Senha,
   Nome,
   Dinheiro,
   Skin,
   Admin,
   Genero,
   Habilitacao,
   Nivel,
   XP
};
new pDados[MAX_PLAYERS][pInfo];
//---------------------(Variaves (new))------------------------//
new bool:logado[MAX_PLAYERS];
new Erro[MAX_PLAYERS];
new bool:motor[MAX_PLAYERS];
new moto[MAX_PLAYERS];
new CarroAuto[MAX_PLAYERS];
new CAuto[MAX_PLAYERS];
new veiculo[MAX_PLAYERS];
new bool:tb[MAX_PLAYERS];
new skina[MAX_PLAYERS];

//---------------------(Salvar/Carregar/GetName)------------------------//
stock PlayerArquivo (playerid){
      new Arquivo[40];
      format(Arquivo, sizeof(Arquivo), Contas, GetName(playerid));
      return Arquivo;

}
stock GetName(playerid)
{
   new Name[MAX_PLAYER_NAME];
   GetPlayerName(playerid, Name, sizeof(Name));
   return Name;
}

//salvar
SalvarPlayer(playerid)
{
    if(DOF2_FileExists(PlayerArquivo(playerid)))
    {
      pDados[playerid][Skin] = GetPlayerSkin(playerid);

      DOF2_CreateFile(PlayerArquivo(playerid));
      DOF2_SetInt(PlayerArquivo(playerid), "Dinheiro", GetPlayerMoney(playerid));
      DOF2_SetInt(PlayerArquivo(playerid), "Skin", pDados[playerid][Skin]);
      DOF2_SetInt(PlayerArquivo(playerid), "Admin", pDados[playerid][Admin]);
      DOF2_SetInt(PlayerArquivo(playerid), "Genero", pDados[playerid][Genero]);
      DOF2_SetInt(PlayerArquivo(playerid), "Habilitacao", pDados[playerid][Habilitacao]);
      DOF2_SetInt(PlayerArquivo(playerid), "Nivel", pDados[playerid][Nivel]);
      DOF2_SetInt(PlayerArquivo(playerid), "XP", pDados[playerid][XP]);

      DOF2_SaveFile();

    }

}
//Carregar
Cp(playerid)
{
    if(DOF2_FileExists(PlayerArquivo(playerid)))
    {
      pDados[playerid][Dinheiro] = DOF2_GetInt(PlayerArquivo(playerid), "Dinheiro");
      pDados[playerid][Skin] = DOF2_GetInt(PlayerArquivo(playerid), "Skin");
      pDados[playerid][Admin] = DOF2_GetInt(PlayerArquivo(playerid), "Admin");
      pDados[playerid][Genero] = DOF2_GetInt(PlayerArquivo(playerid), "Genero");
      pDados[playerid][Habilitacao] = DOF2_GetInt(PlayerArquivo(playerid), "Habilitacao");
      pDados[playerid][Nivel] = DOF2_GetInt(PlayerArquivo(playerid), "Nivel");
      pDados[playerid][XP] = DOF2_GetInt(PlayerArquivo(playerid), "XP");

      logado[playerid] = true;
      GivePlayerMoney(playerid, pDados[playerid][Dinheiro]);

      SetPlayerSkin(playerid, pDados[playerid][Skin]);


	}
       return 1;
}




main()
{

}

public OnGameModeInit()
{
    SetTimer("PayDay", 1800000, true);

	SetGameModeText("Cidade Curitiba");
    CreatePickup(1239, 0, 1659.1929, -2262.0166, -2.7284);
    Create3DTextLabel("Use F (100R$)", 0x00FFFFAA, 1659.1929, -2262.0166, -2.7284, 30.0, 0, 0);
    DisableInteriorEnterExits();
    CreatePickup(1318, 0, 594.3734, -1250.4337, 18.2566);
    Create3DTextLabel("Auto Escola (Use F)", 0x00FFFFAA, 594.3734, -1250.4337, 18.2566, 15.0, 0, 0);
    CreatePickup(1318, 0, 1481.3558, -1771.0681, 18.7891);
    Create3DTextLabel("Prefeitura (Use F)", 0x00FFFFAA, 1481.3558, -1771.0681, 18.7891, 15.0, 0, 0);

	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    if(DOF2_FileExists(PlayerArquivo(playerid)))
    {
          ShowPlayerDialog(playerid, dl, DIALOG_STYLE_PASSWORD, " Login ", "Digite sua senha", "Login", "Sair");
    }
    else{
         ShowPlayerDialog(playerid, dr, DIALOG_STYLE_PASSWORD, " Registro ", "Digite sua senha", "Login", "Sair");

    }
    return 1;
}

public OnPlayerConnect(playerid)
{

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    DestroyVehicle(moto[playerid]);
    DestroyVehicle(veiculo[playerid]);

    SalvarPlayer(playerid);
    return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
  new StringTexto[128];

  format(StringTexto, 128, "%s[%d] diz: %s", GetName(playerid), playerid, text);
  new Float:X, Float:Y, Float:Z; GetPlayerPos(playerid, X, Y, Z);
  for(new i; i < MAX_PLAYERS; i++)
  {
    if(IsPlayerConnected(i))
    {
    if(IsPlayerInRangeOfPoint(i, 30.0, X, Y, Z))
    {
       if(pDados[playerid][Admin] == 0) {

       SendClientMessage(i, -1, StringTexto);
        }
        else
    {
    if(pDados[playerid][Admin] == 1)
    {
       format(StringTexto, 128, "%s[%d]{C154C1}[Helper]{FFFFFF} diz: %s", GetName(playerid), playerid, text);
       SendClientMessage(i, -1, StringTexto);
     }
     else if(pDados[playerid][Admin] == 2)
    {
       format(StringTexto, 128, "%s[%d]{FFDC33}[Sub-Administrador]{FFFFFF} diz: %s", GetName(playerid), playerid, text);
       SendClientMessage(i, -1, StringTexto);
     }
     else if(pDados[playerid][Admin] == 3)
    {
       format(StringTexto, 128, "%s[%d]{FFB841}[Administrador]{FFFFFF} diz: %s", GetName(playerid), playerid, text);
       SendClientMessage(i, -1, StringTexto);
     }
     else if(pDados[playerid][Admin] == 4)
    {
       format(StringTexto, 128, "%s[%d]{77DDE7}[Master]{FFFFFF} diz: %s", GetName(playerid), playerid, text);
       SendClientMessage(i, -1, StringTexto);
     }
     else if(pDados[playerid][Admin] == 5)
    {
       format(StringTexto, 128, "%s[%d]{0095B6}[Fundador]{FFFFFF} diz: %s", GetName(playerid), playerid, text);
       SendClientMessage(i, -1, StringTexto);
     }

    }
    }
   }
 }

  return 0;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success) {

new str[150];
format(str, sizeof (str), "{FF0000}ERRO: >> ESSE COMANDO NAO EXISTE [%s]", cmdtext);

if(!success) return SendClientMessage(playerid, -1, str);

return true;

}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{


    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    DisablePlayerCheckpoint(playerid);
    if(CAuto[playerid] == 1)
        {
       SetTimerEx("Tempo", 1200000, false, "d", playerid);
       SetPlayerCheckpoint(playerid, 630.6104, -1389.7646, 13.3320, 3.0);
       CAuto[playerid] += 1;
       return 1;
    }

if(CAuto[playerid] == 2)
        {
       SetPlayerCheckpoint(playerid, 627.4473, -1580.7321, 15.5174, 3.0);
       CAuto[playerid] += 1;
       return 1;
     }
if(CAuto[playerid] == 3)
        {
       SetPlayerCheckpoint(playerid, 533.6907, -1584.9364, 16.0078, 3.0);
       CAuto[playerid] += 1;
       return 1;
    }
if(CAuto[playerid] == 4)
        {
       SetPlayerCheckpoint(playerid, 429.2861, -1476.3051, 30.1330, 3.0);
       CAuto[playerid] += 1;
       return 1;
    }
if(CAuto[playerid] == 5)
        {
       SetPlayerCheckpoint(playerid, 391.6804, -1518.8679, 32.0077, 3.0);
       CAuto[playerid] += 1;
       return 1;
    }
if(CAuto[playerid] == 6)
{
    SetPlayerPos(playerid, 1490.2841, 1305.5541, 1093.2891);
     SetPlayerInterior(playerid, 3);
     GameTextForPlayer(playerid, "Aprovado", 2000, 4);
     DestroyVehicle(CarroAuto[playerid]);
     CAuto[playerid] = 0;
    pDados[playerid][Habilitacao] = 1;

    return 1;
}

    return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    	if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP) && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff",4.1,0,1,1,0,0);
	if(newkeys == 16 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
{
	cmd_moto(playerid, "");
    cmd_entrar(playerid, "");
    cmd_sair(playerid, "");
    cmd_autoescola(playerid, "");
}


    return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
       switch(dialogid)
    {

      case dr:
      {

         if(response)
         {
             if(strlen(inputtext) < 5 || strlen(inputtext) > 20 || !strlen(inputtext))
             {
                     DOF2_CreateFile(PlayerArquivo(playerid));
             DOF2_SetString(PlayerArquivo(playerid), "Senha", inputtext);

                  ShowPlayerDialog(playerid, dr, DIALOG_STYLE_PASSWORD, "Registro", "{A5260A}Senha deve conter entre 5\n e 20 caracteries", "Cadastrar", "Sair");
                  return 1;
             }

             return ShowPlayerDialog(playerid, dg, DIALOG_STYLE_LIST, "----------------(Escolha Seu Genero)-------------", "Homem\n Mulher", "Confirmar", "Sair");


             }
           else
           {
             Kick(playerid);
           }
         }
         case dl:
         {
            if(response)
            {
                 if(strlen(inputtext) < 5 || strlen(inputtext) > 20 || !strlen(inputtext))
                 {
                     SendClientMessage(playerid, 0xFF0000AA, "{A5260A}[LOGIN] Senha incorreta");
                     ShowPlayerDialog(playerid, dl, DIALOG_STYLE_PASSWORD, "Login", "{A5260A}Digite sua senha correta", "Logar", "Sair");
                     return 1;
                 }
                 if(strcmp(inputtext, DOF2_GetString(PlayerArquivo(playerid), "Senha" )) == 0)
                 {


                      SetSpawnInfo(playerid, 0, pDados[playerid][Skin], 1643.1838, -2286.8879, -1.1962, 0, 0, 0, 0, 0, 0, 0);

                       Cp(playerid);


                      SpawnPlayer(playerid);
                      SetPlayerSkin(playerid, pDados[playerid][Skin]);

                      SendClientMessage(playerid, 0x08F868AA, "{116B07}[LOGIN]{98FB98} Logado Com Sucesso");

                 }
                 else
                 {
                     Erro[playerid] ++;
                     if (Erro[playerid] == 3)
                     {
                         SalvarPlayer(playerid);
                         Kick(playerid);
                     }
                         SendClientMessage(playerid, 0xFF0000AA, "Digite A senha corretamente");

                     }
                 }
                 else
                 {
                    Kick(playerid);
                 }
             }
         }
         if(dialogid == dg)
         {
           if(response)
           {
             if(listitem == 0)
             {
                 DOF2_CreateFile(PlayerArquivo(playerid));
             DOF2_SetString(PlayerArquivo(playerid), "Nome", GetName(playerid));
             DOF2_SetInt(PlayerArquivo(playerid), "Dinheiro", 0);
             DOF2_SetInt(PlayerArquivo(playerid), "Skin", 26);
             DOF2_SetInt(PlayerArquivo(playerid), "Admin", 0);
             DOF2_SetInt(PlayerArquivo(playerid), "Genero", 1);
             pDados[playerid][Genero] = 1;
             GivePlayerMoney(playerid, 500);
             logado[playerid] = true;

             SetSpawnInfo(playerid, 0, 26, 1643.1838, -2286.8879, -1.1962, 0, 0, 0, 0, 0, 0, 0);

             SendClientMessage(playerid, -1, "{116B07}[LOGIN]{98FB98} Logado Com Sucesso");

             SpawnPlayer(playerid);
             return 1;
             }
             else if(listitem == 1)
             {
                 DOF2_CreateFile(PlayerArquivo(playerid));
             DOF2_SetString(PlayerArquivo(playerid), "Nome", GetName(playerid));
             DOF2_SetInt(PlayerArquivo(playerid), "Dinheiro", 0);
             DOF2_SetInt(PlayerArquivo(playerid), "Skin", 41);
             DOF2_SetInt(PlayerArquivo(playerid), "Admin", 0);
             DOF2_SetInt(PlayerArquivo(playerid), "Genero", 2);
             pDados[playerid][Genero] = 2;
             GivePlayerMoney(playerid, 500);
             logado[playerid] = true;

             SetSpawnInfo(playerid, 0, 41, 1643.1838, -2286.8879, -1.1962, 0, 0, 0, 0, 0, 0, 0);

             SendClientMessage(playerid, -1, "{116B07}[LOGIN]{98FB98} Logado Com Sucesso");

             SpawnPlayer(playerid);
             return 1;
             }

           }
         }
         if(response)
         {
           if(dialogid == da)
           {
              if(listitem == 0)
              {
                new din = GetPlayerMoney(playerid);
                if(din < 500) return SendClientMessage(playerid, 0xFF0000AA, "[Auto-Escola] Voce Nao Tem 500R$");
                GivePlayerMoney(playerid, -500);
                SetPlayerCheckpoint(playerid, 623.7818, -1296.0537, 15.1483, 3.0);
                CarroAuto[playerid] = AddStaticVehicle(560, 584.6789, -1308.7776, 13.9326, 0, 0, 0);
                PutPlayerInVehicle(playerid, CarroAuto[playerid], 0);
                SetVehicleParamsEx(CarroAuto[playerid], 0, 0, 0, 0, 0, 0, 0);
                SendClientMessage(playerid, 0xFF0000AA, "Use /motor para ligar o Veiculo");
                SetPlayerInterior(playerid, 0);
                CAuto[playerid] = 1;
              }
           }
         }

    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
//---------------------(Criar Veiculo)------------------------//
CMD:veh(playerid, params[])
{

    if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
    if(pDados[playerid][Admin] < 4) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin Level 4 ou maior");
    if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");

    new veh;

    new Float:X, Float:Y, Float:Z; GetPlayerPos(playerid, X, Y, Z);
    if(sscanf(params, "d", veh)) return 1;
    veiculo[playerid] = AddStaticVehicle(veh, X, Y, Z, 0, 0, 0);
    PutPlayerInVehicle(playerid, veiculo[playerid], 0);
    return 1;
}
// /motor
CMD:motor(playerid)
{

   if(IsPlayerInAnyVehicle(playerid))
   {
     new Veiculo[MAX_PLAYERS];

     Veiculo[playerid] = GetPlayerVehicleID(playerid);
     if(motor[playerid] == false)
     {
         SetVehicleParamsEx(Veiculo[playerid], 1, 1, 0, 0, 0, 0, 0);
         GameTextForPlayer(playerid, "Veiculo Ligado", 2000, 4);
         motor[playerid] = true;

     }
     else
     {
         SetVehicleParamsEx(Veiculo[playerid], 0, 0, 0, 0, 0, 0, 0);
         GameTextForPlayer(playerid, "Veiculo Desligado", 2000, 4);
         motor[playerid] = false;

     }
    }
    return 1;
}
//puxar moto
  CMD:moto(playerid)
 {
            if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "Voce nao esta logado");
            if(moto[playerid] != 0) return SendClientMessage(playerid, 0xFF0000AA, "[Moto] Voce ja pegou uma moto");

       if(IsPlayerInRangeOfPoint(playerid, 3.0, 1659.1929, -2262.0166, -2.7284))
        {
		  new Din = GetPlayerMoney(playerid);
			  if(Din > 100)
			  {
              new mot[MAX_PLAYERS] = 0;
			  GivePlayerMoney(playerid, -100);
			  moto[playerid] = AddStaticVehicle(462,1657.1847, -2250.9380, -2.8516, 86.3988, 1, 2);
              SetVehicleParamsEx(mot[playerid], 0, 0, 0, 0, 0, 0, 0) ;
              SendClientMessage(playerid, 0xFF0000AA, "Digite /motor para ligar este veiculo");
              motor[playerid] = false;

              PutPlayerInVehicle(playerid, moto[playerid], 0);
              SendClientMessage(playerid, 0x80FF80AA, "Voce Alugou um veiculo");
			  			  }
			  else
			  {

				 SendClientMessage(playerid, 0xFF0000AA, "Voce Nao tem 100 Reais");
				 }


        }
    return 1;
 }
 // entrar/sair
CMD:entrar(playerid)
{
  if(IsPlayerInRangeOfPoint(playerid, 3.0, 594.3734, -1250.4337, 18.2566))
  {
           SendClientMessage(playerid, 0x00FFFFAA, "[Server]Voce entrou na Auto escola");
        SetPlayerPos(playerid, 1494.325195, 1304.942871, 1093.289062);
        SetPlayerInterior(playerid, 3);
        CreatePickup(1581, 0, 1490.2841, 1305.5541, 1093.2891);
        Create3DTextLabel("Precione F", 0x00FFFFAA, 1490.2841, 1305.5541, 1093.2891, 15.0, 0, 0);

  }
  else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1481.3558, -1771.0681, 18.7891))
  {
           SendClientMessage(playerid, 0x00FFFFAA, "[Server]Voce entrou na Prefeitura");
        SetPlayerPos(playerid, 384.808624, 173.804992, 1008.382812);
        SetPlayerInterior(playerid, 3);
        CreatePickup(1210, 0, 361.8269, 173.4063, 1008.3828);
        Create3DTextLabel("Precione F", 0x00FFFFAA, 361.8269, 173.4063, 1008.3828, 15.0, 0, 0);

  }

  return 1;
}
//sair
CMD:sair(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 4.0, 1494.325195, 1304.942871, 1093.289062))

    {
        SendClientMessage(playerid, -1, "Voce saiu da Auto Escola");

        SetPlayerPos(playerid, 594.3734, -1250.4337, 18.2566);
        SetPlayerInterior(playerid, 0);


    }
    else if(IsPlayerInRangeOfPoint(playerid, 4.0, 384.808624, 173.804992, 1008.382812))

    {
        SendClientMessage(playerid, -1, "Voce saiu da Prefeitura");

        SetPlayerPos(playerid, 1481.3558, -1771.0681, 18.7891);
        SetPlayerInterior(playerid, 0);


    }
    return 1;
}

CMD:autoescola(playerid)
{
   if(IsPlayerInRangeOfPoint(playerid, 3.0, 1490.2841, 1305.5541, 1093.2891))
   {

      ShowPlayerDialog(playerid, da, DIALOG_STYLE_LIST, "-------------(Auto escola)-----------", "Habilitacao de Carros\t [500R$]", "Confirmar", "Sair");

   }
   return 1;
}
forward Tempo(playerid);
public Tempo(playerid)
{
   SetPlayerPos(playerid, 1490.2841, 1305.5541, 1093.2891);
     SetPlayerInterior(playerid, 3);
     GameTextForPlayer(playerid, "Reprovado", 2000, 4);
     DestroyVehicle(CarroAuto[playerid]);
     CAuto[playerid] = 0;

}
//Administracao
CMD:pegaradmin(playerid)
{
   if(!IsPlayerAdmin(playerid))  return  SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao Esta Logado No Rcon");
   SendClientMessage(playerid, 0x40C739AA, "[Server] Agora Voce e um Admin Level 5");
   pDados[playerid][Admin] = 5;

   return 1;

  }
CMD:daradmin(playerid, params[])
{
  new id, level, str[100];
  if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
  if(pDados[playerid][Admin] < 5) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin Level 5");

  if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");

  if(sscanf(params, "dd", id, level)) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Use /daradmin [playerid] [level]");
  if(level > 5 || level < 1) return  SendClientMessage(playerid, 0xFF0000AA, "[Erro] level entre 1 e 5");
  pDados[id][Admin] = level;
  format(str, 100, "[Server] O Admin %s Setou Voce Como Admin Level %d!", GetName(playerid), pDados[playerid][Admin]);
  SendClientMessage(playerid, 0x00FF00AA, str);
  return 1;
}
CMD:aa(playerid)
{
    if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
    if(pDados[playerid][Admin] < 1) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin");
    if(pDados[playerid][Admin] == 1) return  ShowPlayerDialog(playerid, daa1, DIALOG_STYLE_MSGBOX, "Comandos de Helper", " /ir [playerid]\n /ls\n /kick [playerid]", "Confirmar", "Sair");
    if(pDados[playerid][Admin] == 2) return  ShowPlayerDialog(playerid, daa2, DIALOG_STYLE_MSGBOX, "Comandos de Sub-Admin", "/trazer [playerid]\n /ir [playerid]\n /kick [playerid]", "Confirmar", "Sair");
    if(pDados[playerid][Admin] == 3) return  ShowPlayerDialog(playerid, daa3, DIALOG_STYLE_MSGBOX, "Comandos de Admin", "/trazer [playerid]\n /ir [playerid]\n /kick [playerid]\n /ban [playerid]\n /evida [playerid]\n", "Confirmar", "Sair");
    if(pDados[playerid][Admin] == 4) return  ShowPlayerDialog(playerid, daa4, DIALOG_STYLE_MSGBOX, "Comandos de Master", "/setskin[playerid] [Skinid]\n /dardinheiro [playerid]\n /ecolete [playerid]\n /veh [vehid]\n /trazer [playerid]\n /ir [playerid]\n /kick [playerid]\n /banir [playerid]\n /evida [playerid]\n", "Confirmar", "Sair");
    if(pDados[playerid][Admin] == 5) return  ShowPlayerDialog(playerid, daa5, DIALOG_STYLE_MSGBOX, "Comandos de Fundador", "/dararma [playerid] [weponid] [municao]\n /setskin[playerid] [Skinid]\n /dardinheiro [playerid]\n /ecolete [playerid]\n /veh [vehid]\n/trazer [playerid]\n /ir [playerid]\n /kick [playerid]\n /banir [playerid]\n /evida [playerid]\n", "Confirmar", "Sair");



    return 1;
}
CMD:tb(playerid)
{
   new str[100];
   if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
   if(pDados[playerid][Admin] < 1) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin");
   if(tb[playerid] == true)
   {
      tb[playerid] = false;
      SetPlayerSkin(playerid, skina[playerid]);
      SetPlayerHealth(playerid, 100.0);
      format(str, 50, "[Admin] O Administrador %s Esta Jogando", GetName(playerid));
      SendClientMessageToAll(0x00FFFFAA, str);

      return 1;
   }
   if(tb[playerid] == false)
   {
      skina[playerid] = GetPlayerSkin(playerid);
      tb[playerid] = true;
      SetPlayerSkin(playerid, 217);
      format(str, 50, "[Admin] O Administrador %s Esta Trabalhando", GetName(playerid));
      SendClientMessageToAll(0x00FFFFAA, str);
      SetTimerEx("Infinity", 1000, false, "d", playerid);

      return 1;
   }


   return 1;
}
forward infinity(playerid);
public infinity(playerid)
{
  if(tb[playerid] == true)
  {
  SetPlayerHealth(playerid, 100.0);
  SetTimerEx("Infinity", 1000, false, "d", playerid);

  }
  return 1;
}
CMD:kick(playerid, params[])
{
  new id, str[50];
  if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
   if(pDados[playerid][Admin] < 1) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin");
   if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");
   if(sscanf(params, "d", id)) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Use /kick [playerid]");
   format(str, 50, "[Kick] O Admin %s Kickou %s", GetName(playerid), GetName(id));
   SendClientMessageToAll(0xFF0000AA, str);
   Kick(id);

   return 1;
}
CMD:banir(playerid, params[])
{
  new id, str[50];
  if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
   if(pDados[playerid][Admin] < 4) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin levep 4 ou mais");
  if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");
   if(sscanf(params, "d", id)) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Use /banir [playerid]");
   format(str, 50, "[Ban] O Admin %s Ban %s", GetName(playerid), GetName(id));
   SendClientMessageToAll(0xFF0000AA, str);
   Ban(id);

   return 1;
}
CMD:ir(playerid, params[])
{
  new id, str[50];
  new Float:X, Float:Y, Float:Z;
  new interior;
  if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
   if(pDados[playerid][Admin] < 1) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin");
   if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");
   if(sscanf(params, "d", id)) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Use /ir [playerid]");
   format(str, 50, "[Admin] O Adimin %s Venho Ate voce", GetName(playerid));
   SendClientMessage(id, 0x0080FFAA, str);

   interior = GetPlayerInterior(id);
   GetPlayerPos(id, X, Y, Z);
   SetPlayerPos(playerid, X, Y, Z);
   SetPlayerInterior(playerid, interior);
   return 1;
}
CMD:trazer(playerid, params[])
{
  new id, str[50];
  new Float:X, Float:Y, Float:Z;
  new interior;
  if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
   if(pDados[playerid][Admin] < 2) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin level 2 ou mais");
   if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");
   if(sscanf(params, "d", id)) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Use /trazer [playerid]");
   format(str, 50, "[Admin] O Adimin %s Levou voce ate ele", GetName(playerid));
   SendClientMessage(id, 0x0080FFAA, str);

   interior = GetPlayerInterior(playerid);
   GetPlayerPos(playerid, X, Y, Z);
   SetPlayerPos(id, X, Y, Z);
   SetPlayerInterior(id, interior);
   return 1;
}
CMD:dardinheiro(playerid, params[])
{
  new id, m, str[50];
  if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
   if(pDados[playerid][Admin] < 5) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin level 5");
   if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");
   if(sscanf(params, "dd", id, m)) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Use /dardinheiro [playerid] [Quantidade]");
   format(str, 50, "[Kick] O Admin %s te deu %d R$", GetName(playerid), m);
   SendClientMessage(id, 0x80FF00AA, str);
   GivePlayerMoney(id, m);

   return 1;
}
CMD:evida(playerid, params[])
{
  new id, str[50];
  if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
   if(pDados[playerid][Admin] < 3) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin level 3 ou mais");
   if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");
   if(sscanf(params, "d", id)) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Use /evida [playerid]");
   format(str, 50, "[Admin] O Admin %s Encheu Sua vida", GetName(playerid));
   SendClientMessage(id, 0x80FF00AA, str);
   SetPlayerHealth(id, 100.0);

   return 1;
}
CMD:ecolete(playerid, params[])
{
  new id, str[50];
  if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
   if(pDados[playerid][Admin] < 4) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin level 4 ou mais");
   if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");
   if(sscanf(params, "d", id)) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Use /ecolete [playerid]");
   format(str, 50, "[Admin] O Admin %s Encheu Seu Colete", GetName(playerid));
   SendClientMessage(id, 0x80FF00AA, str);

   SetPlayerArmour(id, 100.0);

   return 1;
}
CMD:setskin(playerid, params[])
{
  new id, s, str[50];
  if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
   if(pDados[playerid][Admin] < 4) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin level 4 ou mais");
   if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");
   if(sscanf(params, "dd", id, s)) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Use /setskin [playerid] [skinid]");
   format(str, 50, "[Admin] O Admin %s Mudou Sua Skin", GetName(playerid));
   SendClientMessage(id, 0x80FF00AA, str);
   SetPlayerSkin(id, s);


   return 1;
}
CMD:dararma(playerid, params[])
{
  new id, a, m, str[50];
  if(logado[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta Logado");
   if(pDados[playerid][Admin] < 5) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao e um Admin level 5");
   if(tb[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Voce Nao esta trabalhando use /tb");
   if(sscanf(params, "ddd", id, a, m)) return SendClientMessage(playerid, 0xFF0000AA, "[Erro] Use /dararma [playerid] [weponid] [municao]");
   format(str, 50, "[Admin] O Admin %s te deu uma arma", GetName(playerid));
   SendClientMessage(id, 0x80FF00AA, str);
   GivePlayerWeapon(id, a, m);



   return 1;
}
CMD:prefeitura(playerid)
{
   if(IsPlayerInRangeOfPoint(playerid, 3.0, 361.8269, 173.4063, 1008.3828))
   {

      ShowPlayerDialog(playerid, dp, DIALOG_STYLE_LIST, "-------------(Empregos)-----------", "Acoqueiro\t [level 0]", "Confirmar", "Sair");

   }
   return 1;
}
forward PayDay();
public PayDay()
{
   new qXP[MAX_PLAYERS];

    for(new i = 0; i < MAX_PLAYERS; i++)
    {
                 if(logado[i] == false) return 1;
         if(pDados[i][XP] == 0)
         {
           qXP[i] = 4;
         }
         else
         {
           qXP[i] += qXP[i];
         }
         pDados[i][XP] += 1;
         GivePlayerMoney(i, 500);
         SendClientMessage(i, -1, "-=-=-=-=-=-= PAYDAY -=-=-=-=-=-=");
         new strl[160];
         format(strl, 160, "XP : %d/%d", pDados[i][XP], qXP[i]);
         SendClientMessage(i, -1, strl);
         if(pDados[i][XP] >= qXP[i])
         {
           pDados[i][Nivel] += 1;
           pDados[i][XP] = 0;
           SendClientMessage(i, -1, "Voce Subiu de Nivel");
           format(strl, 160, "Nivel : %d", pDados[i][Nivel]);
           SendClientMessage(i, -1, strl);

         }
         else
         {

             format(strl, 160, "Nivel : %d", pDados[i][Nivel]);
             SendClientMessage(i, -1, strl);

         }


    }
    return 1;
}




