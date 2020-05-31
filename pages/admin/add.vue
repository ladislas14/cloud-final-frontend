<template>
  <section class="hero ">
    <div class="hero-body">
      <div class="container">
        <h1 class="title">New post</h1>

        <form id="newPost" method="post" @submit.prevent="processForm">
          <div class="field">
            <label class="label">Title</label>
            <div class="control">
              <input id="title" v-model="title" type="text" name="title" />
            </div>
          </div>

          <div class="field">
            <label class="label">Content</label>
            <div class="control">
              <textarea
                id="content"
                v-model="content"
                name="content"
                cols="30"
                rows="10"
              ></textarea>
            </div>
          </div>

          <div class="field">
            <label class="label">Photo</label>
            <div class="control">
              <input id="file" type="file" name="file" @change="previewFiles" />
            </div>
          </div>

          <div class="field is-grouped">
            <div class="control">
              <input type="submit" class="button is-link" />
            </div>
          </div>
        </form>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  middleware: 'authenticated',
  data() {
    return {
      errors: [],
      title: null,
      content: null,
      file: ''
    }
  },
  methods: {
    async processForm() {
      this.$axios.setToken(this.$store.state.auth.accessToken, 'Bearer')
      const { data } = await this.$axios.post('/blog/photo', {
        filePath: this.file.name,
        contentType: this.file.type
      })

      const fileName = data.data.photoId.fileName
      const signedUrl = data.data.photoId.s3Url

      const options = {
        headers: {
          'Content-Type': this.file.type
        }
      }

      this.$axios.setToken(false)
      await this.$axios.put(signedUrl, this.file, options)

      const body = {
        title: this.title,
        content: this.content,
        photoId: fileName
      }

      this.$axios.setToken(this.$store.state.auth.accessToken, 'Bearer')
      await this.$axios.post('blog', body)

      this.$router.push('/admin')
    },
    previewFiles(e) {
      this.file = e.target.files[0]
    }
  }
}
</script>
