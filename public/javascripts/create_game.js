Vue.component('game-creation', {
  template: `
    <form @submit.prevent="formSubmitted">
      <div class="field">
        <label class="label">Name</label>
        <div class="control">
          <input v-model="name" class="input" type="text" placeholder="Give your game a name">
        </div>
      </div>

      <div class="field">
        <label class="label">Board Height: </label>
        <div class="select">
          <select v-model="y_size">
            <option v-for='n in 16'>{{ n+4 }}</option>
          </select>
        </div>
      </div>

      <div class="field">
        <label class="label">Board Width: </label>
        <div class="select">
          <select v-model="x_size">
            <option v-for='n in 16'>{{ n+4 }}</option>
          </select>
        </div>
      </div>

      <div class="field">
        <label class="label">Number of Mines: </label>
        <div class="select">
          <select v-model="mine_count">
            <option v-for='n in 50'>{{ n }}</option>
          </select>
        </div>
      </div>

      <div class="control">
        <button class="button is-primary">Create</button>
      </div>

    </form>
  `,

  methods: {
    formSubmitted() {
      axios.post('/api/games/', this.$data).then((response) => {
        let game_id = response.data.game.id;
        window.location.href = '/game/' + game_id;
      });
    }
  },

  data() {
    return {
      name: '',
      y_size: 5,
      x_size: 5,
      mine_count: 5
    }
  }
});

new Vue({
  el: '.game-creation-container',
});
