{* Меню пользователя 

	{$oUserCurrent->getDisplayName()} - имя
	{$oUserCurrent->getUserWebPath()} - ссылка профиля
	
*}
<div class="ls-userbar-user-nav js-userbar-user-nav">
	
	<a href="/sandbox/add/" class="ls-userbar-user-nav-write-topic js-modal-toggle-default" data-lsmodaltoggle-modal="syn-create-modal">
        <span class="btn__text">Написать</span>       
    </a>
	
	
    <div class="ls-userbar-user-nav-toggle js-userbar-user-nav-toggle">
		<img src="{$oUserCurrent->getProfileAvatarPath(48)}" alt="{$oUserCurrent->getDisplayName()}"" class="ls-userbar-user-nav-avatar" />
	</div>

    {component 'nav'
        classes = 'ls-userbar-user-nav-menu js-userbar-user-nav-menu'
        hook = 'user'
        hookParams = [ user => $oUserCurrent ]
        items = [
            [ 'name' => 'whois',      'text' => {lang name='user.profile.nav.info'},         'url' => "{$oUserCurrent->getUserWebPath()}" ],
            [ 'name' => 'wall',       'text' => {lang name='user.profile.nav.wall'},         'url' => "{$oUserCurrent->getUserWebPath()}wall/", 'count' => $iUserCurrentCountWall ],
            [ 'name' => 'created',    'text' => {lang name='user.profile.nav.publications'}, 'url' => "{$oUserCurrent->getUserWebPath()}created/topics/", 'count' => $iUserCurrentCountCreated ],
            [ 'name' => 'favourites', 'text' => {lang name='user.profile.nav.favourite'},    'url' => "{$oUserCurrent->getUserWebPath()}favourites/topics/", 'count' => $iUserCurrentCountFavourite ],
            [ 'name' => 'friends',    'text' => {lang name='user.profile.nav.friends'},      'url' => "{$oUserCurrent->getUserWebPath()}friends/", 'count' => $iUserCurrentCountFriends ],
            [ 'name' => 'activity',   'text' => {lang name='user.profile.nav.activity'},     'url' => "{$oUserCurrent->getUserWebPath()}stream/" ],
            [ 'name' => 'talk',       'text' => {lang name='user.profile.nav.messages'},     'url' => "{router page='talk'}", 'count' => $iUserCurrentCountTalkNew ],
            [ 'name' => 'settings',   'text' => {lang name='user.profile.nav.settings'},     'url' => "{router page='settings'}" ],
            [ 'name' => '-' ],
			[ 'name' => 'admin',      'text' => {lang name='admin.title'},                   'url' => "{router page='admin'}", 'is_enabled' => $oUserCurrent && $oUserCurrent->isAdministrator() ],
            [ 'name' => 'logout',     'text' => {lang name='auth.logout'},                   'url' => "{router page='auth'}logout/?security_ls_key={$LIVESTREET_SECURITY_KEY}" ]
        ]}
</div>