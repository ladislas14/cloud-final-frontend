<template>
  <div class="container">
    <h1>Sign in to access the secret page</h1>
    <p v-if="wrongCredentials" class="error">Wrong credentials.</p>
    <div>
      <label for="username">
        <input id="username" v-model="username" type="text" />
      </label>
      <label for="password">
        <input id="password" v-model="password" type="password" />
      </label>
      <button @click="postLogin">login</button>
    </div>
  </div>
</template>

<script>
const Cookie = process.client ? require('js-cookie') : undefined

export default {
  middleware: 'notAuthenticated',
  data() {
    return {
      username: null,
      password: null,
      wrongCredentials: false
    }
  },
  methods: {
    async postLogin() {
      const response = await this.$axios.post('/auth/login', {
        username: this.username,
        password: this.password
      })

      if (response.status === 201 && response.data.accessToken) {
        const auth = {
          accessToken: response.data.accessToken
        }
        this.$store.commit('setAuth', auth) // mutating to store for client rendering
        Cookie.set('auth', auth) // saving token in cookie for server rendering
        this.$router.push('/admin')
        this.$axios.setToken(response.data.accessToken, 'Bearer')
      } else {
        this.wrongCredentials = true
      }
    }
  }
}
</script>
