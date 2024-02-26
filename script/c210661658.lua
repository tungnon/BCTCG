--Courier Cat
--Link Monster (LD,D,RD)
--3 monsters with different names, except tokens.
--(1) Cannot be used as Link material.
--(2) This card's ATK becomes the combined original ATK of the monsters used as link material.
--(3) Your opponent cannot activate cards or effects during the Battle Phase.
local s,id=GetID()
function s.initial_effect(c)
	--Link Summon
	c:EnableReviveLimit()
	Link.AddProcedure(c,aux.NOT(aux.FilterBoolFunctionEx(Card.IsType,TYPE_TOKEN)),3,3,s.lcheck)
	--cannot link material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Atk becomes Original ATK of the monsters used
	local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetOperation(s.sucop)
    c:RegisterEffect(e2)
end
--lcheck
function s.lcheck(g,lc,sumtype,tp)
	return g:CheckDifferentProperty(Card.GetCode,lc,sumtype,tp)
end
--e2
function s.sucop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
    local g=c:GetMaterial()
    local atk=0
    local tc=g:GetFirst()
    for tc in aux.Next(g) do
        local lk=tc:GetAttack()
        atk=atk+lk
    end
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(atk)
    e1:SetReset(RESET_EVENT+RESE
end