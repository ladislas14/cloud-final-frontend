<template>
  <nav class="navbar">
    <div class="container">
      <div class="navbar-brand">
        <a class="navbar-item" href="../">My Blog</a>
        <span class="navbar-burger burger" data-target="navbarMenu">
          <span></span>
          <span></span>
          <span></span>
        </span>
      </div>
      <div id="navbarMenu" class="navbar-menu">
        <div class="navbar-end">
          <nuxt-link
            to="/"
            class="navbar-item is-active is-size-5 has-text-weight-semibold"
            >Home</nuxt-link
          >
          <nuxt-link
            to="/login"
            class="navbar-item is-active is-size-5 has-text-weight-semibold"
            >Login</nuxt-link
          >
        </div>
      </div>
    </div>
  </nav>
</template>

<style>
nav.navbar {
  height: 6rem !important;
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06) !important;
}
</style>
