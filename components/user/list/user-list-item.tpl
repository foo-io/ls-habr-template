{$component = 'user-list-item'}
{component_define_params params=[ 'user' ]}

{if $user->getUser()}
    {$user = $user->getUser()}
{/if}

{* Описание *}
{capture 'content'}
    {$session = $user->getSession()}
    {$usernote = $user->getUserNote()}
    {$isOnline = $user->isOnline()}

    {* Рейтинг *}
    <div class="{$component}-rating" title="{lang 'vote.rating'}">
        <i class="fa fa-bar-chart" aria-hidden="true"></i> {$user->getRating()}
    </div>

    <div class="{$component}-username">
        {* Имя *}
        {if $user->getProfileName()}
            <a href="{$user->getUserWebPath()}" class="{$component}-name">
                {$user->getProfileName()|escape}
            </a>
        {/if}
		
        {* Логин *}
        <a href="{$user->getUserWebPath()}" class="{$component}-login">
            {$user->getLogin()}
        </a>
    </div>

    {* Статус *}
    <div class="{$component}-status {if $isOnline}{$component}-status--online{/if}">
        {if $isOnline}
            {$aLang.user.status.online}
        {elseif $session}
            {$date = {date_format date=$session->getDateLast() hours_back="12" minutes_back="60" day_back="8" now="60*5" day="day H:i" format="j F в G:i"}|lower}

            {if $user->getProfileSex() != 'woman'}
                {lang 'user.status.was_online_male' date=$date}
            {else}
                {lang 'user.status.was_online_female' date=$date}
            {/if}
        {/if}
    </div>

    {* Заметка *}
    {if $usernote}
        <div class="{$component}-note">{$usernote->getText()}</div>
    {/if}
{/capture}


{component 'item'
    content=$smarty.capture.content
    image=[
        'url' => $user->getUserWebPath(),
        'path' => $user->getProfileAvatarPath(48),
        'alt' => $user->getLogin()
    ]}